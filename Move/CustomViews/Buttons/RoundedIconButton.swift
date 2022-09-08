//
//  RoundedIconButton.swift
//  Move
//
//  Created by Raul Pele on 08.09.2022.
//

import SwiftUI

struct RoundedIconButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 13)
                .foregroundColor(.neutralWhite))
            .shadow(color: .primaryDark.opacity(0.15), radius: 5, x: 7, y: 7)
    }
}

extension ButtonStyle where Self == RoundedIconButton {
    static var roundedIconButton: Self {
        return .init()
    }
}

struct RoundedIconButton_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
        } label: {
            Image("bell")
        }
        .buttonStyle(.roundedIconButton)
    }
}
