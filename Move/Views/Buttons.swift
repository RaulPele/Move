//
//  Buttons.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI


struct FilledButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isEnabled ? .baiJamjureeBold(size: 16) : .baiJamjureeMedium(size: 16))
            .padding(16)
            .background(isEnabled ?
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.accentColor)
                        ) :
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.neutralLightPink, lineWidth: 1)
                                .foregroundColor(.clear)
                        ))
            .foregroundColor(isEnabled ? .neutralWhite : .neutralLightPurple)
    }
}

struct TransparentButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isEnabled ? .baiJamjureeBold(size: 16) : .baiJamjureeMedium(size: 16))
            .padding(16)
            .background(isEnabled ?
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.accentColor, lineWidth: 1)
                                .foregroundColor(.clear)
                        ) :
                        AnyView(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.neutralLightPurple, lineWidth: 1)
                                .foregroundColor(.clear)
                        ))
            .foregroundColor(isEnabled ? Color.accentColor : .neutralLightPurple)
    }
}

extension ButtonStyle where Self == FilledButton {
    static var filledButton: Self {
        return .init()
    }
}

extension ButtonStyle where Self == TransparentButton {
    static var transparentButton: Self {
        return .init()
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Button("QweqwE") {
            
        }
        .buttonStyle(.transparentButton)
        .disabled(true)
    }
}
