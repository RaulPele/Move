//
//  ScooterCardView.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import SwiftUI

struct ScooterCardView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            topSectionView
            bottomSectionView
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, maxHeight: UIScreen.main.bounds.height * 0.4, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(.neutralWhite))
        .shadow(radius: 10)
    }
}

private extension ScooterCardView {
    var scooterImageView: some View {
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .foregroundColor(.neutralLightPurple.opacity(0.15))
                .frame(maxWidth: 152, maxHeight: 152)
                .rotationEffect(.degrees(45))
                .offset(y: -45)
            
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
            
            Text("#AB23")
                .foregroundColor(.primaryDark)
                .font(.baiJamjureeBold(size: 20))
            
            HStack(spacing: 7) {
                Image("battery-full")
                
                Text("100%")
                    .foregroundColor(.primaryDark)
                    .font(.body2())
            }
        }
    }
    
    var locationView: some View {
        return  HStack(spacing: 8) {
            Image("location-pin")
            Text("Str. Avram Iancu nr 26 Cladirea 2")
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
            Spacer()
            
            Button {
                
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.filledButton)
        }
        .padding(24)
    }
}

struct ScooterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ScooterCardView()
                .previewDevice(device)
        }
    }
}
