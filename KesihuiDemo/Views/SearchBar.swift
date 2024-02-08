//
//  SearchBar.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/5.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            if text.count > 0 {
                Button(action: {
                    withAnimation {
                        text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }) {
                    Text("Cancel")
                        .foregroundColor(.gray)
                        .padding(8)
                }
                .opacity(text.isEmpty ? 0 : 1)
                .disabled(text.isEmpty)
            }
        }
    }
}

//#Preview {
//    SearchBar(text: .constant("test"))
//}
