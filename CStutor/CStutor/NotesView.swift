//
//  NotesView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 04.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isPresented = false
    var body: some View {
        NavigationView{
            List(userManager.notes, id: \.self){ idea in
                NavigationLink(destination: IdeaView(idea: idea)){
                    Text("\(idea.task)")
                }
            }
            .navigationBarTitle("Идеи")
            .navigationBarItems(trailing: Button(action: {self.isPresented.toggle()}) {
                Image(systemName: "square.and.pencil")
            })
            .sheet(isPresented: $isPresented) {
                CreatingView(showModal: self.$isPresented).environmentObject(self.userManager)
            }
        }.onAppear { self.userManager.getIdeas() }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
