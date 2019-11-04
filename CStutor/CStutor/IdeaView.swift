//
//  IdeaView.swift
//  CSTutor
//
//  Created by Даниил Палеев on 04.11.2019.
//  Copyright © 2019 Даниил Палеев. All rights reserved.
//

import SwiftUI

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
            result.wrappedValue = newSize.height 
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


struct IdeaView: View {
    @State var idea: Idea
    @EnvironmentObject var userManager: UserManager
    @State private var dynamicHeight: CGFloat = 800
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack{
            UITextViewWrapper(text: $idea.idea, calculatedHeight: $dynamicHeight)
            .frame(maxHeight: dynamicHeight)
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
            .padding()
            Spacer()
            Button(action: {self.userManager.editIdea(idea: self.idea)}) {
                Text("Сохранить").padding()
            }
        }
        .navigationBarTitle("\(idea.task)")
        .navigationBarItems(trailing: Button(action: {
            self.userManager.deleteIdea(idea: self.idea)
            self.mode.wrappedValue.dismiss()
        }) {
            Image(systemName: "trash")
        })
        
    }
}

struct IdeaView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaView(idea: Idea())
    }
}
