//
//  LessonModel.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation

struct Lesson: Decodable { // Урок
    var id: Int
    var title: String
    var theme: Int
    var text: String
    var tasks: [Int]
    
}

