//
//  Tasks.swift
//  CSTutor
//
//  Created by Даниил Палеев on 04.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation

struct Tasks: Decodable, Hashable {
    var todo: [Int]
    var wa: [Int]
    init(){
        self.todo = []
        self.wa = []
    }
}
