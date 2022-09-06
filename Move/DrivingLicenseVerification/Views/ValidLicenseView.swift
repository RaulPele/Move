//
//  ValidLicenseView.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import SwiftUI

struct ValidLicenseView: View {
    let onOpenMap: () -> Void
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            
            VStack(spacing: 67) {
                Spacer()
                Image("oval-checkmark")
                Text("We’ve succesfuly validated your driving license")
                    .font(.heading1())
                    .foregroundColor(Color.neutralWhite)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                
                Spacer()
                Spacer()
                
                Button {
                    onOpenMap()
                } label: {
                    Text("Find scooters")
                        .font(.button1())
                        .frame(maxWidth:.infinity)
                }
                .buttonStyle(.filledButton)
            }
            .padding(24)
        }
    }
}

struct ValidLicenseView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ValidLicenseView(onOpenMap: {})
                .previewDevice(device)
        }
    }
}
