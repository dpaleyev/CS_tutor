//
//  StarterView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct StarterView: View {
    @EnvironmentObject var userViewModel: UserManager
    var body: some View {
        Group {
            if self.userViewModel.isRegistered {
            HomeView()
          } else {
            LoginView(keyboardHandler: KeyboardFollower())
          }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
            .environmentObject(UserManager())
    }
}
