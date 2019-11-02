//
//  ThemeView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct ThemeView: View {
    @State var title: String
    @State var lessonsManager: LessonsManager
    var body: some View {
        List(lessonsManager.lessons, id: \.id) { lesson in
            NavigationLink(destination: LessonDetails()){
                Text("\(lesson.title)")
            }
        }.navigationBarTitle(Text("\(title)"))
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(title: "Графы", lessonsManager: LessonsManager(num: 3))
    }
}
