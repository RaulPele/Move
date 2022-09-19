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
                .foregroundColor(.neutralLightPurple))
    }
}

class PinTextFieldViewModel: ObservableObject {
    let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    
    @Published var pinCode: String = "" {
        didSet {
            if pinCode.count > limit && oldValue.count <= limit {
                pinCode = oldValue
            }
        }
    }
}

struct PinTextField: View {
    let numberOfDigits: Int
    @StateObject private var viewModel: PinTextFieldViewModel
    @FocusState var isFocused: Bool

    init(numberOfDigits: Int) {
        self.numberOfDigits = numberOfDigits
        self._viewModel = StateObject(wrappedValue: PinTextFieldViewModel(limit: numberOfDigits))
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
        TextField("", text: $viewModel.pinCode)
            .accentColor(.clear)
//            .tint(.clear)
            .foregroundColor(.clear)
            .focused($isFocused)
            .keyboardType(.numberPad)
            
            
//            .hidden()

    }
    
    var pinSquaresView: some View {
        HStack(spacing: 16) {
            ForEach(0..<numberOfDigits, id: \.self) { i in
                let digit = i < viewModel.pinCode.count ? String(viewModel.pinCode[i]) : ""
                DigitView(digit: digit, index: i)
            }
        }
    }
}

struct PinTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PurpleBackgroundView()
            PinTextField(numberOfDigits: 4)
        }
    }
}
