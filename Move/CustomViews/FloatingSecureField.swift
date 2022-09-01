//
//  FloatingSecureField.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import SwiftUI

struct FloatingSecureField: View {
    let title: String
    @Binding var text: String
    
    @State var isSecured = true
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.neutralGray)
                        .font(.body1())
                        .offset(y: text.isEmpty ? 0 : -25)
//                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                        .padding(.vertical, 10)
                    
                    Group {
                        if isSecured {
                            SecureField("", text: $text)
                            
                        } else {
                            TextField("", text: $text)
                            
                        }
                    }
                    .foregroundColor(text.isEmpty ? .neutralGray : .neutralWhite)
                    .disableAutocorrection(true)
                    .font(.body1())
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    
                }
                .animation(.spring(response: 0.2, dampingFraction: 0.5), value: text)
                
                if !text.isEmpty{
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(isSecured ? "eye" : "eye-off")
                    }
                }
            }
            
            Divider()
                .frame(height: isFocused ? 2 : 1)
                .background(isFocused ? Color.neutralWhite : Color.neutralGray)
                .padding(.top, 6)
        }
    }
}

//struct FloatingSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatingSecureField()
//    }
//}
