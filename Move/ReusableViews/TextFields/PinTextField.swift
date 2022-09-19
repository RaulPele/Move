//
//  PinTextField.swift
//  Move
//
//  Created by Raul Pele on 19.09.2022.
//

import SwiftUI

struct DigitView: View {
    var digit: String
    let index: Int
    
    var body: some View {
        Text(digit)
            .frame(width: 52, height: 52)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 18)
                .foregroundColor(digit.isEmpty ? .neutralLightPurple : .neutralWhite))
    }
}

struct PinTextField: View {
    let numberOfDigits: Int
    @Binding var pinCode: String
    @FocusState var isFocused: Bool

    init(pinCode: Binding<String>, numberOfDigits: Int) {
        self.numberOfDigits = numberOfDigits
        self._pinCode = pinCode
    }
    
    
    var body: some View {
        ZStack {
            backgroundField
            pinSquaresView.onTapGesture {
                isFocused = true
            }
        }
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

private extension PinTextField {
    var backgroundField: some View {
        TextField("", text: $pinCode)
            .accentColor(.clear)
            .foregroundColor(.clear)
            .focused($isFocused)
            .keyboardType(.numberPad)
            .onChange(of: $pinCode.wrappedValue) { newValue in
                if newValue.count > numberOfDigits  {
                    pinCode = String(newValue.prefix(numberOfDigits))
                }
            }
    }
    
    var pinSquaresView: some View {
        HStack(spacing: 16) {
            ForEach(0..<numberOfDigits, id: \.self) { i in
                let digit = i < pinCode.count ? String(pinCode[i]) : ""
                DigitView(digit: digit, index: i)
            }
        }
    }
}

struct PinTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PurpleBackgroundView()
            PinTextField(pinCode: .constant("1234"), numberOfDigits: 4)
        }
    }
}
