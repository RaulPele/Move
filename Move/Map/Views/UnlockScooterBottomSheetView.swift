//
//  UnlockScooterCardView.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import SwiftUI

struct UnlockScooterBottomSheetView: View {
    let scooter: Scooter
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            
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
//                Spacer()
                scanningButtonsView
            }
            .padding(.top, 28)
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
        }
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
                
            } label: {
                Text("123")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
        }
    }
}

extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>,
                                    @ViewBuilder sheetView: @escaping () -> SheetView,
                                    onDismiss: @escaping () -> Void) -> some View {
        
        return self
            .background(
                HalfSheet(sheetView: sheetView(), showSheet: showSheet, onDismiss: onDismiss)
            )
    }
}

struct UnlockScooterBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            Button {
                
            } label: {
                Text("present")
            }
            .halfSheet(showSheet: .constant(true)) {
                UnlockScooterBottomSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 82, location: .init()))
            } onDismiss: {
                print("Dismissed")
            }
            .previewDevice(device)

                
        }
    }
}
