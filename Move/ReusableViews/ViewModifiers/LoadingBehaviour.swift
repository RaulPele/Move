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
                .overlay(ActivityIndicator(isVisible: $showLoadingIndicator, color: .white).frame(width: 30, height: 30)))
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
