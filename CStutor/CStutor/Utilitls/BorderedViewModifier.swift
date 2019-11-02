//
//  BorderedViewModifier.swift
//  CSTutor
//
//  Created by Даниил Палеев on 30.10.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
      .overlay(
        RoundedRectangle(cornerRadius: 9)
          .stroke(lineWidth: 3)
          .foregroundColor(.blue)
      )
      .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
  }
}

extension View {
  func bordered() -> some View {
    ModifiedContent(content: self, modifier: BorderedViewModifier())
  }
}
