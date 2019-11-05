//
//  ChartView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 03.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct ChartView: View { // Графики по дням
    @State var res: [Int]
    var body: some View {
        HStack(alignment: .center){
            ForEach(0...6, id: \.self) {col in
                ZStack{
                    VStack{
                        Spacer()
                        Capsule().frame(width: 40, height: CGFloat(max(40, self.getK(c: col))), alignment: .bottom)
                        Text("\(self.getWeekDay(day: self.getDay() - col))")
                        Text("\(self.res[col])").foregroundColor(Color.green)
                    }
                }
            }
        }
    }
    func getK(c: Int) -> Int{ // получение высоты
        return Int((Double(self.res[c])/Double(max(self.res.max()!, 1)) * 200))
    }
    func getDay() -> Int{ // получение номера дня недели
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday
    }

    func getWeekDay(day: Int) -> String{ // получение дня недели
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

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(res: [3, 4, 0, 0, 4, 5, 1])
    }
}
