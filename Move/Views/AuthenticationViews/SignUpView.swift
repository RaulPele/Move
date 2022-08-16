//
//  SignUpView.swift
//  Move
//
//  Created by Raul Pele on 16.08.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundView()
            
            VStack(alignment: .leading, spacing: 30) {
                Image("SmallLogoWhite")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                
                Text("Let's get started")
                    .font(.baiJamjureeBold(size: 32))
                    .foregroundColor(.neutralWhite)
                
                Text("Sign up or login and start riding right away")
                    .font(.baiJamjureeMedium(size: 20))
                    .foregroundColor(.neutralGray)
                
                FloatingTextField(title: "Email address", text: $email)
                FloatingTextField(title: "Username", text: $username)
                FloatingTextField(title: "Password", text: $password)
                
                Button("Get started") {
                    print("on get started click")
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.filledButton)
//                .disabled(false)
                
                
            }
            .padding(.horizontal, 24)

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
