//
//  BorderedRoundedIconButton.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import Foundation
import SwiftUI

struct BorderedRoundedIconButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 13)
                .stroke(Color.roundedButtonBorder, lineWidth: 1)
                .foregroundColor(.neutralWhite)
                        )
    }
}

extension ButtonStyle where Self == BorderedRoundedIconButton {
    static var borderedRoundedIconButton: Self {
        return .init()
    }
}

struct BorderedRoundedIconButton_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
        } label: {
            Image("bell")
        }
        .buttonStyle(.borderedRoundedIconButton)
    }
}
