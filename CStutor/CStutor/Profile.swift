//
//  Profile.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

struct Profile : Codable {
    var username: String
    var email: String
    var password: String
    var judge_id: String
  
    init() {
        self.username = ""
        self.email = ""
        self.password = ""
        self.judge_id = ""
    }
  
}
