//
//  BackgroundView.swift
//  Move
//
//  Created by Raul Pele on 12.08.2022.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.primaryLight
                .ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: 94)
                    .foregroundColor(.neutralWhite)
                    .opacity(0.05)
                    .frame(width: 327, height: 327)
                    .rotationEffect(.degrees(45))
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 164)
                    .foregroundColor(.neutralWhite)
                    .opacity(0.05)
                    .frame(width: 423, height: 423)
                    .rotationEffect(.degrees(45))
                    
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
