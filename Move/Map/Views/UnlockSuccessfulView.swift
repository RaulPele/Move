//
//  ValidCodeView.swift
//  Move
//
//  Created by Raul Pele on 20.09.2022.
//

import SwiftUI

struct UnlockSuccessfulView: View {
    var body: some View {
        ZStack(alignment: .top) {
            PurpleBackgroundView()
            VStack(spacing: 0) {
                Text("Unlock successful")
                    .font(.heading1())
                    .foregroundColor(.neutralWhite)
                    .multilineTextAlignment(.center)
                    
                
                Image("oval-checkmark")
                    .padding(.top, 107)
                    .padding(.bottom, 36)
                
                Text("Please respect all the driving regulations and other participants in traffic while using our scooters")
                    .font(.body1())
                    .foregroundColor(.neutralWhite.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .frame(maxHeight: .infinity)
            

        }
    }
}

struct ValidCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            UnlockSuccessfulView()
                .previewDevice(device)
        }
    }
}
