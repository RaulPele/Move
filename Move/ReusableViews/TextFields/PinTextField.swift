//
//  PinTextField.swift
//  Move
//
//  Created by Raul Pele on 19.09.2022.
//

import SwiftUI

//struct DigitTextFieldStyle: TextFieldStyle {
//
//    func _body(configuration: TextField<Self._Label>) -> some View {
//            configuration
//            .background(RoundedRectangle(cornerRadius: 18)
//                .foregroundColor( ? .neutralWhite : .neutralLightPurple)
//            )
//            .cornerRadius(18)
//            .frame(width:52, height: 52)
//
//        }
//}

struct DigitView: View {
    @Binding var digit: String
    @FocusState var focusedField: Int?
    
    let index: Int
    
    var body: some View {
        TextField("", text: $digit)
            .focused($focusedField, equals: index)
            .frame(width: 52, height: 52)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 18)
                .foregroundColor((focusedField == index || digit != "") ? .neutralWhite : .neutralLightPurple)
            )
    }
}

struct PinTextField: View {
    let numberOfDigits = 4
    @State var pinDigits = ["", "", "", ""]
    @FocusState var focusedFieldIndex: Int?
    
    var body: some View {
        pinSquaresView
    }
    
}

private extension PinTextField {
    
    var pinSquaresView: some View {
        HStack(spacing: 16) {
            ForEach(0..<numberOfDigits, id: \.self) { i in
                DigitView(digit: $pinDigits[i], focusedField: _focusedFieldIndex ,index: i)
                    .onChange(of: pinDigits[i]) { newValue in
                        if let focusedFieldIndex = focusedFieldIndex {
                            print(focusedFieldIndex)
                            if newValue == "" {
                                self.focusedFieldIndex = focusedFieldIndex - 1
                            }else {
                                self.focusedFieldIndex = focusedFieldIndex + 1
                            }
                        }
                    }
            }
        }
    }
}

struct PinTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PurpleBackgroundView()
            PinTextField()
        }
    }
}
