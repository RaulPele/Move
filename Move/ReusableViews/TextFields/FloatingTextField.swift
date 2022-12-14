//
//  FloatingTextField.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    @Binding var text: String
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.neutralGray)
                        .font(.body1())
                        .offset(y: text.isEmpty ? 0 : -25)
                        .padding(.vertical, 10)
                    
                    TextField("", text: $text)
                        .foregroundColor(text.isEmpty ? .neutralGray : .neutralWhite)
                        .disableAutocorrection(true)
                        .font(.body1())
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                    
                }
                .animation(.spring(response: 0.2, dampingFraction: 0.5), value: text)
                
                if isFocused && !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image("close-circle")
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
        ForEach(devices) { device in
            FloatingTextField(title: "Title", text: .init(get: {
                "raul.pele2001@gmail.com"
            }, set: { value in
                
            }))
            .previewDevice(device)
        }
        
    }
}
