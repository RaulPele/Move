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
    var color: Color = .white
    
    func body(content: Content) -> some View {
        if showLoadingIndicator {
            return AnyView(content
                .disabled(true)
                .overlay(ActivityIndicator(isVisible: $showLoadingIndicator, color: color).frame(width: 30, height: 30)))
        } else {
            return AnyView(content)
        }
    }
}

extension View {
    func hasLoadingBehaviour(showLoadingIndicator: Binding<Bool>, indicatorColor: Color = .white) -> some View {
        modifier(LoadingBehaviour(showLoadingIndicator: showLoadingIndicator, color: indicatorColor))
    }
}
