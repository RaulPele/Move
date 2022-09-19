//
//  SerialNumberUnlockView.swift
//  Move
//
//  Created by Raul Pele on 16.09.2022.
//

import SwiftUI

struct SerialNumberUnlockView: View {
    @State var text: String = ""
    var body: some View {
        ZStack(alignment: .top) {
            PurpleBackgroundView()

            GeometryReader { geo in

                ScrollView() {
                    VStack(spacing: 55) {
                        titleBarView
                        descriptionView

                        Spacer()
                        PinTextField(pinCode: $text, numberOfDigits: 4)
                        
                        Spacer()
                        Spacer()
                        
                        Text("Alternatively you can unlock using")
                            .font(.body1())
                            .foregroundColor(.neutralWhite)
//                            .frame(maxHeight:.infinity, alignment: .bottom)
                            .padding(.bottom, 100)
                            
                        
                    }
                    .padding(.horizontal, 24)
                    .frame(minHeight: geo.size.height)
                }
            }
        }
    }
}

private extension SerialNumberUnlockView {
    var titleBarView: some View {
        return HStack(spacing: 0) {
            Image("close-icon")
                
            Spacer()
            Text("Enter serial number")
                .font(.heading3())
                .foregroundColor(.neutralWhite)
            Spacer()
        }
        
    }
    
    var descriptionView: some View {
        VStack(spacing: 16) {
            Text("Enter the scooter's serial number")
                .font(.heading1())
                .foregroundColor(.neutralWhite)
                .multilineTextAlignment(.center)
            
            Text("You can find it on the scooter's front panel")
                .font(.body1())
                .foregroundColor(.neutralWhite.opacity(0.6))
                .multilineTextAlignment(.center)
        }
    }
}

struct SerialNumberUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            SerialNumberUnlockView()
                .previewDevice(device)
        }
    }
}
