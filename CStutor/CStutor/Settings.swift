//
//  Settings.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

struct Settings : Codable {
    var rememberUser: Bool = false
    var regprobl = false
    var authprobl = false
    var token: String = ""
    var addingIdeaProbl = false
}
