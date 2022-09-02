//
//  ActivityIndicator.swift
//  Move
//
//  Created by Raul Pele on 01.09.2022.
//

import SwiftUI
import ActivityIndicatorView

struct ActivityIndicator: View {
    @Binding var isVisible: Bool
    var color: Color = .white
    
    var body: some View {
        ActivityIndicatorView(isVisible: $isVisible, type: .arcs(count: 3, lineWidth: 1))
            .foregroundColor(color)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isVisible: .init(get: {
            return true
        }, set: { newVal in
            
        }), color: .primaryLight)
        .frame(width: 100, height: 100)
    }
}
