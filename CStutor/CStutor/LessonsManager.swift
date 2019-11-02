//
//  LessonsManager.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class LessonsManager: ObservableObject {
    @EnvironmentObject var userManager: UserManager
    var didChange = PassthroughSubject<LessonsManager, Never>()
    var lessons: [Lesson] = []{
      didSet {
        didChange.send(self)
      }
    }
    init(num:Int) {
        let url = URL(string: "http://localhost:8000/lesson/theme/\(num)/")!
        var request = URLRequest(url: url)
        request.setValue("Token 7304f93d968a0f76590c10c9f8d1190dba213684", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            guard let data = data else { return }
            let lessons = try! JSONDecoder().decode([Lesson].self, from: data)
            DispatchQueue.main.async {
                self.lessons = lessons
            }
        }.resume()
    }
}
