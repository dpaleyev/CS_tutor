//
//  HomeView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 31.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var selectedView = 2
    var body: some View {
        TabView(selection: $selectedView) {
            BookView()
                .tabItem {
                Image(systemName: "book").resizable()
                Text("Учебник")
            }.tag(1)
            StatisticView()
                .tabItem {
                Image(systemName: "star").resizable()
                Text("Статистика")
                    
            }.tag(2)
            NotesView()
                .tabItem {
                Image(systemName: "list.bullet").resizable()
                Text("Идеи")
            }.tag(3)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
