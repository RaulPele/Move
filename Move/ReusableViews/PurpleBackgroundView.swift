//
//  BackgroundView.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import SwiftUI

struct PurpleBackgroundView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 94)
                .foregroundColor(.neutralWhite)
                .opacity(0.05)
                .frame(maxWidth: 327, maxHeight: 327)
                .rotationEffect(.degrees(60))
                .offset(x: 130)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 164)
                .foregroundColor(.neutralWhite)
                .opacity(0.05)
                .frame(maxWidth: 423, maxHeight: 423)
                .rotationEffect(.degrees(10))
                .offset(x: -150, y: 60)
            
        }
        .background(Color.primaryLight)
    }
}

struct PurpleBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PurpleBackgroundView()
    }
}
