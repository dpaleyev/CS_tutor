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
    @Published
    var profile: Profile = Profile()
  
    @Published
    var settings: Settings = Settings()
  
    var isRegistered: Bool {
        return settings.token != " "
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
}
