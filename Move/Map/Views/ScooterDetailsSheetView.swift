//
//  ScooterDetailsSheetView.swift
//  Move
//
//  Created by Raul Pele on 22.09.2022.
//

import SwiftUI

struct ScooterDetailsSheetView: View {
    let scooter: Scooter
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            
            VStack(spacing: 20) {
                HStack(alignment: .center, spacing: 0) {
                    scooterDetailsView
                    Spacer()
                    scooterImageView
                }
                
                Button {
                    
                } label: {
                    Text("Start ride")
                        .frame(maxWidth:.infinity)
                }
                .buttonStyle(.filledButton)

                
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            .padding(.bottom, 46)
//            .frame(maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.bottom)
        }
        Spacer()
    }
}

private extension ScooterDetailsSheetView {
    var scooterDetailsView: some View {
        VStack(alignment: .leading,spacing: 4 ) {
            Text("Scooter")
                .font(.heading4())
                .foregroundColor(.primaryDark.opacity(0.6))
            
            Text(verbatim: "#\(scooter.scooterNumber)")
                .font(.heading1())
                .foregroundColor(.primaryDark)
            
            BatteryView(batteryPercentage: scooter.batteryPercentage)
        }
    }
    
    var scooterImageView: some View {
        ZStack {
            Image("SheetScooterImage")
                .resizable()
                .scaledToFit()
            
            Image("SheetScooterRectangleBackground")
        }
    }
}

struct ScooterDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
//            ZStack {
//
//            }
//            .halfSheet(showSheet: .constant(true)) {
//                ScooterDetailsSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 82, location: .init()))
//            } onDismiss: {
//
//            }
//            .previewDevice(device)
            
            ZStack {
                Color.red
                Sheet(showSheet: .constant(true)) {
                    ScooterDetailsSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 82, location: .init()))
                }
            }
            .previewDevice(device)
        }
    }
}