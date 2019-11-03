//
//  Statistics.swift
//  CSTutor
//
//  Created by Даниил Палеев on 03.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation

struct Statistics: Codable, Hashable{
    var completed: Int
    var tried: Int
    var day_statistic: [Int]
    var theme_statistic: [Theme]
    init(){
        self.completed = 0
        self.tried = 0
        self.day_statistic = [0, 0, 0, 0, 0, 0, 0]
        self.theme_statistic = []
    }
}

struct Theme: Codable, Hashable {
    var name: String
    var url: String
    var compl: Int
    var tasks: Int
}
