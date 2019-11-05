//
//  LessonDetails.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct LessonDetails: View { //страница урока
    @State var lesson: Lesson
    var body: some View {
        ScrollView{
            Text(lesson.title)
                .font(.largeTitle)
        
            Text(lesson.text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                
            ForEach(lesson.tasks, id: \.self) { task in
                Button(action: {
                    guard let url = URL(string: "https://timus.online/problem.aspx?space=1&num=\(String(task))") else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Timus: \(String(task))").padding(5)
                        
                }
            }
                
        }
    }
}

struct LessonDetails_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetails(lesson: Lesson(id: 1, title: "Алгоритм Дейкстры", theme: 3, text: "smoibvyftcdrct fvybhnijmbgvcftdtfvygbuhnijbgvy cftfvygbuhinvy", tasks: [1005, 1006] ))
    }
}
