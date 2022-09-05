//
//  DrivingLicensePendingVerificationView.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import SwiftUI

struct DrivingLicensePendingVerificationView: View {
    @StateObject private var pendingVerificationViewModel = DrivingLicensePendingVerificationViewModel()
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            
            VStack(spacing: 34) {
                Text("We are currently verifying your driving license")
                    .foregroundColor(.neutralWhite)
                    .font(.heading1())
                    .multilineTextAlignment(.center)
                
                ActivityIndicator(isVisible: $pendingVerificationViewModel.isLoading, color: .white)
                    .frame(width: 35, height: 35)
            }
            .padding(.horizontal, 28)
        }
    }
}

struct DrivingLicensePendingVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLicensePendingVerificationView()
    }
}
