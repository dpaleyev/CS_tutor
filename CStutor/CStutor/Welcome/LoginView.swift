//
//  LoginView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 31.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var keyboardHandler: KeyboardFollower
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    TextField("Username", text: $userManager.profile.username).padding(.bottom, 5)
                    
                    TextField("Password", text: $userManager.profile.password).padding(.bottom, 5)
                }.padding(.leading)
                    .padding(.trailing)
                    .font(Font.system(size: 20, design: .default))
                HStack {
                  Spacer()
                
                  Toggle(isOn: $userManager.settings.rememberUser) {
                    Text("Remember me")
                      .font(.subheadline)
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(.gray)
                  }
                }.padding(.trailing)
                    .padding(.bottom, 5)
                Button(action: self.loginUser) {
                  HStack {
                    Text("Sign in")
                      .font(Font.system(size: 22, design: .default))
                      .bold()
                  }
                }.bordered()
                    .padding(.bottom, 5)
                
                NavigationLink(destination: RegisterView(keyboardHandler: KeyboardFollower())) {
                        Text("Sign up")
                      }.font(Font.system(size: 22, design: .default))
                
                Text("\(userManager.settings.token)")
                
            }
            .alert(isPresented: $userManager.settings.authprobl) {
                Alert(title: Text("Неправильный логин или пароль"))
            }
        }
    }
}

extension LoginView {
    func loginUser() {
        userManager.login()
        if userManager.settings.rememberUser{
            userManager.persistProfile()
            userManager.persistSettings()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static let user = UserManager()
    
    static var previews: some View {
        LoginView(keyboardHandler: KeyboardFollower())
        .environmentObject(user)
    }
}
