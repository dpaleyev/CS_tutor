//
//  Idea.swift
//  CSTutor
//
//  Created by Даниил Палеев on 04.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation

struct Idea: Decodable, Hashable { // Идея
    var id: Int
    var idea: String
    var modified: String
    var task: String
    init(){
        self.id = 0
        self.idea = ""
        self.modified = ""
        self.task = ""
    }
}
