//
//  UserManager.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Combine
import Foundation

final class UserManager: ObservableObject {
    var didChange = PassthroughSubject<UserManager, Never>()
    
    @Published
    var profile: Profile = Profile()
  
    @Published
    var settings: Settings = Settings(){
        didSet {
          didChange.send(self)
        }
    }
    
    @Published
    var statistics: Statistics = Statistics(){
        didSet {
          didChange.send(self)
        }
    }
    
    @Published
    var notes: [Idea] = []{
        didSet {
          didChange.send(self)
        }
    }
    
    @Published
    var tasks: Tasks = Tasks(){
        didSet {
          didChange.send(self)
        }
    }
    
    var isRegistered: Bool {
        return settings.token != ""
    }
  
    init() {
    }
    
    init(name: String) {
      self.profile.username = name
    }
  
    func persistProfile() {
        if settings.rememberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "user-profile")
        }
    }
  
    func persistSettings() {
        if settings.rememberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
        }
    }
    
    func persistStatistics() {
        if settings.rememberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(statistics), forKey: "user-statistics")
        }
    }
  
    func load() {
        if let data = UserDefaults.standard.value(forKey: "user-profile") as? Data {
            if let profile = try? PropertyListDecoder().decode(Profile.self, from: data) {
                self.profile = profile
            }
        }
    
        if let data = UserDefaults.standard.value(forKey: "user-settings") as? Data {
            if let settings = try? PropertyListDecoder().decode(Settings.self, from: data) {
                self.settings = settings
            }
        }
        if let data = UserDefaults.standard.value(forKey: "user-statistics") as? Data {
            if let statistics = try? PropertyListDecoder().decode(Statistics.self, from: data) {
                self.statistics = statistics
            }
        }
    }
  
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user-profile")
        UserDefaults.standard.removeObject(forKey: "user-settings")
        UserDefaults.standard.removeObject(forKey: "user-statistics")
    }
    
    func registrate() {
        let jsonData = try! JSONEncoder().encode(profile)

        let url = URL(string: "http://localhost:8000/register/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.settings.regprobl = true
                    }
                return
            }
            self.login()
        }
        task.resume()
    }
    
    func login()
    {
        let json = [
            "username": profile.username,
            "password": profile.password
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])

        let url = URL(string: "http://localhost:8000/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    self.settings.authprobl = true
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonDict = try decoder.decode([String:String].self, from: data)
                    if let token = jsonDict["token"] {
                        DispatchQueue.main.async {
                            self.settings.token = token
                            if self.settings.rememberUser{
                                self.persistProfile()
                                self.persistSettings()
                            }
                        }
                    }
                }  catch _ as NSError {
                    self.settings.authprobl = true
                }
            } else if error != nil {
                self.settings.authprobl = true
            }
        }
        task.resume()
    }
    
    func getResults() {
        let url = URL(string: "http://localhost:8000/statistics/")!
        var request = URLRequest(url: url)
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            guard let data = data else { return }
            let statistics = try! JSONDecoder().decode(Statistics.self, from: data)
            DispatchQueue.main.async {
                self.statistics = statistics
                self.persistStatistics()
            }
        }.resume()
    }
    
    func getTasks() {
        let url = URL(string: "http://localhost:8000/todo/")!
        var request = URLRequest(url: url)
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            guard let data = data else { return }
            let tasks = try! JSONDecoder().decode(Tasks.self, from: data)
            DispatchQueue.main.async {
                self.tasks = tasks
            }
        }.resume()
    }
    
    func getIdeas(){
        let url = URL(string: "http://localhost:8000/notes/")!
        var request = URLRequest(url: url)
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            guard let data = data else { return }
            let ideas = try! JSONDecoder().decode([Idea].self, from: data)
            DispatchQueue.main.async {
                self.notes = ideas
            }
        }.resume()
    }
    
    func addIdea(idea: Idea){
        
        let json : [String:Any] = [
            "idea": idea.idea,
            "task": idea.task
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let url = URL(string: "http://localhost:8000/notes/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.settings.addingIdeaProbl = true
                    }
                return
            }
            self.getIdeas()
        }
        task.resume()
    }
    
    func deleteIdea(idea: Idea){
        
        let json : [String:Any] = [
            "id": idea.id
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let url = URL(string: "http://localhost:8000/notes/")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.settings.addingIdeaProbl = true
                    }
                return
            }
            self.getIdeas()
        }
        task.resume()
    }
    
    func editIdea(idea: Idea){
        
        let json : [String:Any] = [
            "id": idea.id,
            "idea": idea.idea,
            "task": idea.task
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let url = URL(string: "http://localhost:8000/notes/")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.settings.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.settings.addingIdeaProbl = true
                    }
                return
            }
            self.getIdeas()
        }
        task.resume()
    }
}
