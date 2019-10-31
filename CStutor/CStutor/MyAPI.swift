//
//  MyAPI.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation
import SwiftUI

func LoginAPI(username: String, password: String, userCompletionHandler: @escaping (String?) -> Void){
    let json = [
        "username": username,
        "password": password
    ]
    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])

    let url = URL(string: "http://localhost:8000/login/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                userCompletionHandler(nil)
            return
        }
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let jsonDict = try decoder.decode([String:String].self, from: data)
                if let token = jsonDict["token"] {
                    userCompletionHandler(token)
                }
            }  catch let error as NSError {
                userCompletionHandler(nil)
            }
        } else if let error = error {
            userCompletionHandler(nil)
        }
    }
    task.resume()
}

func RegistrationAPI(profile: Profile, userCompletionHandler: @escaping (String?) -> Void){
    let jsonData = try! JSONEncoder().encode(profile)

    let url = URL(string: "http://localhost:8000/register/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                userCompletionHandler(nil)
            return
        }
        LoginAPI(username: profile.username, password: profile.password) { (token) in
            if let token = token{
                userCompletionHandler(token)
            }
            else{
                userCompletionHandler(nil)
            }
        }
    }
    task.resume()
}
