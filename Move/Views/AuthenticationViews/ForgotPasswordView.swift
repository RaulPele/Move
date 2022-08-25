//
//  ForgotPasswordView.swift
//  Move
//
//  Created by Raul Pele on 22.08.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            PurpleBackgroundView()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Forgot Password")
                    .foregroundColor(.neutralWhite)
                    .font(.heading1())
                
                Text("Enter the email address you’re using for your account bellow and we’ll send you a password reset link.")
                    .foregroundColor(.neutralGray)
                    .font(.body1())
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
