//
//  AuthenticationHeaderView.swift
//  Move
//
//  Created by Raul Pele on 01.09.2022.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    let logoPath: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(logoPath)
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 4)
            
            Text(title)
                .font(.heading1())
                .foregroundColor(.neutralWhite)
            
            Text(description)
                .font(.heading2())
                .foregroundColor(.neutralGray)
        }
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeaderView(logoPath: "SmallLogoWhite", title: "Let's get started", description: "Sign up or login and start riding right away")
    }
}
