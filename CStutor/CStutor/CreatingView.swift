//
//  CreatingView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 04.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI
import UIKit

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        uiView.text = self.text
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        DispatchQueue.main.async {
            result.wrappedValue = newSize.height // !! must be called asynchronously
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>

        init(text: Binding<String>, height: Binding<CGFloat>) {
            self.text = text
            self.calculatedHeight = height
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }
    }

}


struct CreatingView: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var showModal: Bool
    @State var idea = Idea()
    @State private var dynamicHeight: CGFloat = 800
    @State var showAlert = false
    var body: some View {
        VStack{
            HStack{
                Text("Добавление идеи").font(.largeTitle).bold().padding()
                Spacer()
                Button("Готово", action: {
                    self.userManager.addIdea(idea: self.idea)
                    self.idea = Idea()
                    self.showModal = false
                    }).padding()
            }
            TextField("Номер задачи или тема", text: $idea.task)
                .font(Font.system(size: 20, design:.default))
                .padding()
            UITextViewWrapper(text: $idea.idea, calculatedHeight: $dynamicHeight)
                .frame(maxHeight: dynamicHeight)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
                .padding()
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Номер задачи должен быть настоящим"))
        }
    }
}

struct CreatingView_Previews: PreviewProvider {
    static var previews: some View {
        CreatingView(showModal: .constant(true))
    }
}
