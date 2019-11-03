//
//  StatisticView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 03.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Text("@\(userManager.profile.username)")
                        .font(.title)
                        .foregroundColor(Color.green)
                        .bold()
                        .padding()
                        Spacer()
                }
                HStack{
                    VStack{
                        Text("  Решено:  ").font(.headline)
                        Text("\(userManager.statistics.completed)").font(.largeTitle).bold()
                    }.padding()
                    VStack{
                        Text("Получен WA:").font(.headline)
                        Text("\(userManager.statistics.tried)").font(.largeTitle).bold()
                    }.padding()
                }
                ChartView(res: userManager.statistics.day_statistic)
                
            }
            .navigationBarTitle("Статистика")
        }
        .onAppear { self.userManager.getResults() }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
