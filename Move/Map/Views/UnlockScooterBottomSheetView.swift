//
//  UnlockScooterCardView.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import SwiftUI

struct UnlockScooterBottomSheetView: View {
    let scooter: Scooter
    let onSerialNumberUnlockClicked: (Scooter) -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("You can unlock this scooter through these methods: ")
                    .font(.baiJamjureeBold(size: 16))
                    .foregroundColor(.primaryDark)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 0) {
                    VStack(spacing: 26){
                        scooterDetailsView
                        scooterButtonsView
                    }
                    Spacer()
                    
                    scooterImageView
                }
                scanningButtonsView
            }
            .padding(.top, 28)
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
        }
        .background(RoundedRectangle(cornerRadius: 32)
            .foregroundColor(.neutralWhite)
            .ignoresSafeArea())
    }
}

private extension UnlockScooterBottomSheetView {
    var scooterButtonsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    Image("bell")
                }
                .buttonStyle(.borderedRoundedIconButton)
                
                Text("Ring")
                    .font(.body2())
                    .foregroundColor(.primaryDark)
            }
            
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    Image("missing-icon")
                }
                .buttonStyle(.borderedRoundedIconButton)
                
                Text("Missing")
                    .font(.body2())
                    .foregroundColor(.primaryDark)
            }
        }
    }
    
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
    
    var scanningButtonsView: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                Text("NFC")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
            
            Button {
                
            } label: {
                Text("QR")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
            
            Button {
                onSerialNumberUnlockClicked(scooter)
            } label: {
                Text("123")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
        }
    }
}

struct UnlockScooterBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ZStack {
                Color.red
                
            }
            .overlay {
                Sheet(showSheet: .constant(true), content: {
                    UnlockScooterBottomSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .available, lockedStatus: .unlocked, batteryPercentage: 82, location: .init()), onSerialNumberUnlockClicked: { _ in })
                })
            }
            
            .previewDevice(device)

                
        }
    }
}
