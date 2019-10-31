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
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
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
    }
  
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user-profile")
        UserDefaults.standard.removeObject(forKey: "user-settings")
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
                    self.settings.regprobl = true
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
                        self.settings.token = token
                    }
                }  catch let error as NSError {
                    self.settings.authprobl = true
                }
            } else if let error = error {
                self.settings.authprobl = true
            }
        }
        task.resume()
    }
}
