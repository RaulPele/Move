//
//  UnlockScooterCardView.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import SwiftUI

struct UnlockScooterBottomSheet: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            
            VStack(spacing: 0) {
                Text("You can unlock this scooter through these methods: ")
                    .font(.baiJamjureeBold(size: 16))
                    .foregroundColor(.primaryDark)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 0) {
                    VStack(spacing:0 ) {
                        Text("Scooter")
                        Text("#1893")
                        
                    }
                }
            }
        }
    }
}

struct UnlockScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ZStack
            UnlockScooterCardView()
                .previewDevice(device)
        }
    }
}
