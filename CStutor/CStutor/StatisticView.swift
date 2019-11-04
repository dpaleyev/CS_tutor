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
                
                HStack(alignment: .center){
                    ForEach(0...6, id: \.self) {col in
                        ZStack{
                            VStack{
                                Spacer()
                                Capsule().frame(width: 40, height: CGFloat(max(40, self.getK(c: col))), alignment: .bottom)
                                Text("\(self.getWeekDay(day: self.getDay() - col))")
                                Text("\(self.userManager.statistics.day_statistic[col])").foregroundColor(Color.green)
                            }
                        }
                    }
                }
                
                if userManager.statistics.day_statistic[0] == 0 {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25).fill(Color(hue: 55/360, saturation: 36/100, brightness: 98/100))
                        HStack{
                            Text("Сегодня ты не решил ни одной задачи! Попробуй ещё!")
                                .font(.headline)
                                .foregroundColor(Color.black)
                        }
                        }.frame(height: 100).padding()
                }
                
                if userManager.statistics.day_statistic.reduce(0, +) >= 7 {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25).fill(Color.green)
                        HStack{
                            Text("Ты хорошо постарался на этой неделе! Продолжай в том же духе!")
                                .font(.headline)
                                .foregroundColor(Color.black)
                        }
                    }.frame(height: 100).padding()
                } else{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25).fill(Color(hue: 5/360, saturation: 62/100, brightness: 97/100))
                        HStack{
                            Text("Ты решил мало задач на этой неделе! Ты можешь лучше!")
                                .font(.headline)
                                .foregroundColor(Color.black)
                        }
                    }.frame(height: 100).padding()
                }
                
                ForEach(userManager.statistics.theme_statistic, id: \.self){ theme in
                    HStack{
                        ZStack {
                            Circle()
                                .trim(from: 0, to: CGFloat(self.getProg(t: theme)))
                                .stroke(Color.green, lineWidth:5)
                                .frame(width:85, height: 70)
                                .rotationEffect(Angle(degrees:-90))
                            Text(self.getPercentage(self.getProg(t: theme)))
                        }
                        VStack{
                            HStack{
                                Text("\(theme.name)").font(.headline)
                                Spacer()
                            }
                            HStack{
                                Text("\(theme.compl)/\(theme.tasks)")
                                Spacer()
                            }
                        }
                    }
                }
                
                HStack{
                    Text("Ты можешь решить эти задачи:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Spacer()
                }.padding()
                
                ForEach(userManager.tasks.todo, id: \.self) { task in
                    Button(action: {
                        guard let url = URL(string: "https://timus.online/problem.aspx?space=1&num=\(String(task))") else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Text("•Timis: \(String(task))").padding(5)
                            
                    }
                }

                
                HStack{
                    Text("Попробуй решить ещё раз:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Spacer()
                }.padding()
                
                ForEach(userManager.tasks.wa, id: \.self) { task in
                    Button(action: {
                        guard let url = URL(string: "https://timus.online/problem.aspx?space=1&num=\(String(task))") else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Text("•Timis: \(String(task))").padding(5)
                            
                    }
                }

                
            }
            .navigationBarTitle("Статистика")
            .navigationBarItems(trailing: Button(action: {
                self.userManager.getResults()
                self.userManager.getTasks()
            }) {
            Image(systemName: "arrow.clockwise")
            })
        }
        .onAppear { self.userManager.getResults()
                    self.userManager.getTasks()
        }
    }
    
    func getProg(t: Theme) -> Double{
        let a = Double(t.tasks)
        let b = Double(t.compl)
        return b/a
    }
    
    func getPercentage(_ value:Double) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
    
    func getK(c: Int) -> Int{
        return Int((Double(self.userManager.statistics.day_statistic[c])/Double(max(self.userManager.statistics.day_statistic.max()!, 1)) * 200))
    }
    
    func getDay() -> Int{
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday
    }

    func getWeekDay(day: Int) -> String{
        let nday = (day + 6)%7 + 1
        switch nday {
        case 1:
            return "Вс"
        case 2:
            return "Пн"
        case 3:
            return "Вт"
        case 4:
            return "Ср"
        case 5:
            return "Чт"
        case 6:
            return "Пт"
        case 7:
            return "Сб"
        default:
            return ""
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
