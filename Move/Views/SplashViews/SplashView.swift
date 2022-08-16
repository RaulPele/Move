//
//  SplashView.swift
//  Move
//
//  Created by Raul Pele on 10.08.2022.
//

import SwiftUI

struct SplashView: View {
    let onFinishLoading: () -> Void
    
    var body: some View {
        ZStack {
            Color.primaryLight
                .ignoresSafeArea()
            Image("SplashScreenMoveLogo")
            Image("SplashScreenScooter")
                .offset(x: -116)
            Image("SplashScreenMoveText")
        }
        .onAppear() {
            print("onfinishloading")
            onFinishLoading()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView {
            EmptyView()
        }
    }
}
