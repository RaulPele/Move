//
//  ScooterCardView.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import SwiftUI

struct ScooterCardView: View {
    let scooter: Scooter
    
    @StateObject private var scooterCardViewModel: ScooterCardViewModel
    
    let onUnlockScooterPressed: () -> Void
    
    init(scooter: Scooter, onUnlockScooterPressed: @escaping () -> Void) {
        self.scooter = scooter
        self.onUnlockScooterPressed = onUnlockScooterPressed
        self._scooterCardViewModel = StateObject(wrappedValue: ScooterCardViewModel(scooter: scooter))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topSectionView
            bottomSectionView
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(.neutralWhite))
        .shadow(radius: 10)
        .onAppear {
            scooterCardViewModel.convertScooterLocation()
        }
        
    }
}

private extension ScooterCardView {
    var scooterImageView: some View {
        return ZStack(alignment: .topLeading) {
            Image("ScooterRectangleBackground")
                .resizable()
                .scaledToFit()
            
            Image("CardViewScooterImage")
                .resizable()
                .scaledToFit()
                
        }
    }
    
    var scooterDetailsView: some View {
        return VStack(alignment:.trailing ,spacing: 4) {
            Text("Scooter")
                .foregroundColor(.primaryDark.opacity(0.6))
                .font(.body2())
            
            Text(verbatim: "#\(scooter.scooterNumber)")
                .foregroundColor(.primaryDark)
                .font(.baiJamjureeBold(size: 20))
            
            BatteryView(batteryPercentage: scooter.batteryPercentage)
        }
    }
    
    var locationView: some View {
        return  HStack(spacing: 8) {
            Image("location-pin")
            Text(scooterCardViewModel.scooterAddress)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primaryDark)
                .font(.body2())
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 24) {
            Button {
                
            } label: {
                Image("bell")
            }
            .buttonStyle(.roundedIconButton)
            
            Button {
                
            } label: {
                Image("location-arrow")
            }
            .buttonStyle(.roundedIconButton)
        }
    }
    
    var topSectionView: some View {
        return HStack(alignment: .top, spacing: 0) {
            scooterImageView
            
            VStack(spacing: 21) {
                scooterDetailsView
                buttonsView
            }
            .padding([.top, .trailing], 24)
        }
    }
    
    var bottomSectionView: some View {
        return VStack(spacing: 24) {
            locationView
                .frame(alignment: .top)
            
            Button {
                onUnlockScooterPressed()
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.filledButton)
//            .frame(alignment: .bottom)
        }
        .padding(24)
//        .frame(maxHeight: .infinity)
    }
}

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ScooterCardView(scooter: .init(id: "1231432123", scooterNumber: 1234, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 89, location: Coordinates.ClujNapoca), onUnlockScooterPressed: {  })
                .previewDevice(device)
        }
    }
}
