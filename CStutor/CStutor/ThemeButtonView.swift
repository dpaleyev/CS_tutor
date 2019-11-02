//
//  ThemeButtonView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 02.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct ThemeButtonView: View {
    @State var title: String
    @State var info: String
    @State var col: Color
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(col)
            VStack{
                HStack{
                    Text(title)
                        .font(Font.system(size: 30, design: .default))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .lineLimit(2)
                    Spacer()
                }.layoutPriority(2)
                HStack{
                    Text(info)
                        .font(Font.system(size: 20, design: .default))
                        .font(.body)
                        .foregroundColor(Color.black)
                        .fontWeight(.regular)
                    Spacer()
                }.layoutPriority(1)
            }.padding()
        }.frame(height: 230)
        
    }
}

struct ThemeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeButtonView(title: "Динамическое программирование", info: "Cпособ решения сложных задач путём разбиения их на более простые подзадачи.", col: Color(hue: 235/360, saturation: 11/100, brightness: 81/100))
    }
}
