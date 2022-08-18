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
    @State var isSecured = false
    @State var isShowingPassword = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.neutralGray)
                        .font(text.wrappedValue.isEmpty ? .body1() : .smallText())
                        .offset(y: text.wrappedValue.isEmpty ? 0 : -25)
                        .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
                        .padding(.vertical, text.wrappedValue.isEmpty ? 10 : 0)
                    
                    Group {
                        if isSecured {
                            SecureField("", text: text)
                            
                        } else {
                            TextField("", text: text)

                        }
                    }
                    .foregroundColor(text.wrappedValue.isEmpty ? .neutralGray : .neutralWhite)
                    .disableAutocorrection(true)
                    .font(.body1())
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    
                }
                .animation(.spring(response: 0.2, dampingFraction: 0.5))
                
                if !isSecured && !isShowingPassword {
                    if isFocused && !text.wrappedValue.isEmpty {
                        Button {
                            text.wrappedValue = ""
                        } label: {
                            Image("close-circle")
    //                            .background(.red)
                                
                        }
                    }
                } else {
                    if !text.wrappedValue.isEmpty {
                        Button {
                            isSecured.toggle()
                            isShowingPassword.toggle()
                        } label: {
                            Image(isShowingPassword ? "eye-off" : "eye")
                        }
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

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(title: "Title", text: .init(get: {
            "raul.pele2001@gmail.com"
        }, set: { value in
            
        }))
    }
}
