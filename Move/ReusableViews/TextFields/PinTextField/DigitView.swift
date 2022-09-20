//
//  DigitView.swift
//  Move
//
//  Created by Raul Pele on 20.09.2022.
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

struct DigitView_Previews: PreviewProvider {
    static var previews: some View {
        DigitView(digit: "1", index: 0)
    }
}
