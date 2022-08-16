//
//  FloatingTextField.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    let text: Binding<String>
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.neutralGray)
                    .font(text.wrappedValue.isEmpty ? .baiJamjureeMedium(size: 16) : .baiJamjureeRegular(size: 12))
                    .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                    .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("", text: text)
                    .foregroundColor(text.wrappedValue.isEmpty ? .neutralGray : .neutralWhite)
                    .font(.baiJamjureeMedium(size: 16))
                
                
            }
            .animation(.spring(response: 0.2, dampingFraction: 0.5))
            Divider()
                .frame(height: text.wrappedValue.isEmpty ? 1 : 2)
                .background(text.wrappedValue.isEmpty ? Color.neutralGray : Color.neutralWhite)
                .padding(.top, 10)
            
        }
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(title: "Title", text: .init(get: {
            "Email"
        }, set: { value in
            
        }))
    }
}
