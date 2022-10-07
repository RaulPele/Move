//
//  TripDetailsFullScreenView.swift
//  Move
//
//  Created by Raul Pele on 02.10.2022.
//

import SwiftUI

struct TripDetailsFullScreenView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            VStack(spacing: 44) {
                titleBarView
                tripInformationView
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
        }
    }
}

private extension TripDetailsFullScreenView {
    var titleBarView: some View {
        HStack(spacing: 0) {
            Image("chevron-bottom")
            
            Spacer()
        
            Text("Trip Details")
                .font(.heading3())
                .foregroundColor(.primaryDark)
            
            Spacer()
        }
    }
    
    var tripInformationView: some View {
        HStack {}
    }
}

struct TripDetailsFullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            TripDetailsFullScreenView()
                .previewDevice(device)
        }
    }
}
