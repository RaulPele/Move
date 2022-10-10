//
//  TransparentButton.swift
//  Move
//
//  Created by Raul Pele on 08.09.2022.
//

import SwiftUI

struct TransparentButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isEnabled ? .button1() : .baiJamjureeMedium(size: 16))
//            .padding(16)
            .frame(height: 56)
//            .background(isEnabled ?
//                        AnyView(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color.accent, lineWidth: 1)
//                                .background(RoundedRectangle(cornerRadius: 16)
//                                    .foregroundColor(.clear))
//                        ) :
//                        AnyView(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color.neutralLightPurple, lineWidth: 1)
//                                .background(RoundedRectangle(cornerRadius: 16)
//                                    .foregroundColor(.clear))
//                        ))
            .background(RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.clear))
            .overlay( RoundedRectangle(cornerRadius: 16)
                .stroke(isEnabled ? Color.accent : Color.neutralLightPurple, lineWidth: 1))
            .foregroundColor(isEnabled ? Color.accent : .neutralLightPurple)
    }
}

extension ButtonStyle where Self == TransparentButton {
    static var transparentButton: Self {
        return .init()
    }
}

struct TransparentButton_Previews: PreviewProvider {
    static var previews: some View {
        Button {
        
        } label: {
            Text("qweqwe")
        }
        .disabled(false)
        .buttonStyle(.transparentButton)
    }
}
