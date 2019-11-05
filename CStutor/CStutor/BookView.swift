//
//  BookView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct BookView: View { // страница выбора тем
    var body: some View {
            NavigationView{
                ScrollView{
                    NavigationLink(destination: ThemeView(title: "Динамическое программирование", lessonsManager: LessonsManager(num: 1))){
                        ThemeButtonView(title: "Динамическое программирование", info: "Раздел посвещён способам решения сложных задач путём разбиения их на более простые подзадачи.", col: Color(hue: 235/360, saturation: 11/100, brightness: 81/100)).padding()
                    }
                    NavigationLink(destination: ThemeView(title: "Поиск", lessonsManager: LessonsManager(num: 2))){
                        ThemeButtonView(title: "Поиск", info: "Раздел посвещён алгоритмам для поиска и обработки информации как в структурированных так и неструктурированных данных.", col: Color(hue: 15/360, saturation: 26/100, brightness: 98/100)).padding()
                    }
                    NavigationLink(destination: ThemeView(title: "Графы", lessonsManager: LessonsManager(num: 3))){
                        ThemeButtonView(title: "Графы", info: "Раздел посвещён способам хранения и обработки графа, а так же различным алгоритмам работающим на графах.", col: Color(hue: 86/360, saturation: 19/100, brightness: 85/100)).padding()
                    }
                    NavigationLink(destination: ThemeView(title: "Структуры данных", lessonsManager: LessonsManager(num: 4))){
                        ThemeButtonView(title: "Структуры данных", info: "Раздел посвящён способам хранения и эффективной обработки информации: поиск, изменение, добавление данных.", col: Color(hue: 205/360, saturation: 28/100, brightness: 100/100)).padding()
                    }
                    NavigationLink(destination: ThemeView(title: "Теория чисел", lessonsManager: LessonsManager(num: 5))){
                        ThemeButtonView(title: "Теория чисел", info: "Раздел посвящён разделу математики, изучающему свойства простых чисел, и алгоритмам по взаимодействию с ними.", col: Color(hue: 1/360, saturation: 39/100, brightness: 91/100)).padding()
                    }
                    NavigationLink(destination: ThemeView(title: "Геометрия", lessonsManager: LessonsManager(num: 6))){
                        ThemeButtonView(title: "Геометрия", info: "Раздел посвящён разделу информатики, в котором рассматриваются алгоритмы для решения геометрических задач.", col: Color(hue: 290/360, saturation: 14/100, brightness: 97/100)).padding()
                    }
                }.navigationBarTitle("Учебник")
            }
        
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
