//
//  LoadingBehaviour.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation
import SwiftUI

struct LoadingBehaviour: ViewModifier {
    @Binding var showLoadingIndicator: Bool
    
    func body(content: Content) -> some View {
        if showLoadingIndicator {
            return AnyView(content
                .disabled(true)
                .blur(radius: 1.5)
                .overlay(ActivityIndicator(isVisible: $showLoadingIndicator, color: .white).frame(width: 100, height: 100)))
        } else {
            return AnyView(content)
        }
    }
}

extension View {
    func hasLoadingBehaviour(showLoadingIndicator: Binding<Bool>) -> some View {
        modifier(LoadingBehaviour(showLoadingIndicator: showLoadingIndicator))
    }
}
