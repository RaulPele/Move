//
//  OnboardingSafetyView.swift
//  Move
//
//  Created by Raul Pele on 10.08.2022.
//

import SwiftUI

struct OnboardingView: View {
    let onboardingData: OnboardingData
    let pageIndex: Int
    let numberOfPages: Int
    
    let onNextButtonClicked: () -> Void
    
    var body: some View {
        ZStack {
            Color.neutralWhite
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Image(onboardingData.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 3/5)
                    .clipped()
                
                HStack(spacing: 0) {
                    Text(onboardingData.title)
                        .foregroundColor(.primaryDark)
                        .font(.baiJamjureeBold(size: 32))
                    
                    Spacer()
                    
                    Button("Skip") {
                        
                    }
                    .foregroundColor(.neutralGray)
                    .font(.baiJamjureeSemiBold(size: 14))
                }
                .padding([.top, .leading, .trailing], 24)
                .padding(.bottom, 12)
                
                HStack {
                    Text(onboardingData.description)
                        .foregroundColor(.primaryDark)
                        .font(.baiJamjureeMedium(size: 16))
                        .frame(maxWidth: 2/3 * UIScreen.main.bounds.width, alignment: .leading)
                }
                .padding(.leading, 24)
                
                Spacer()
                
                HStack(spacing: 0) {
                    generatePageIndicator()

                    Spacer()
                    
                    Button {
                        onNextButtonClicked()
                    } label: {
                        HStack {
                            Text(pageIndex != numberOfPages - 1 ? "Next" : "Get started")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(.filledButton)
                }
                .padding([.leading, .trailing], 24)
            }
            .padding(.bottom, 24)
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    func generatePageIndicator() -> some View {
        HStack(spacing: 12) {
            ForEach(0..<numberOfPages, id: \.self) {i in
                if i == pageIndex {
                    RoundedRectangle(cornerRadius: 1.5)
                        .frame(width: 16, height: 4)
                        .foregroundColor(.primaryDark)
                } else {
                    RoundedRectangle(cornerRadius: 1.5)
                        .frame(width: 4, height: 4)
                        .foregroundColor(.neutralGray)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingData: .safety(), pageIndex: 0, numberOfPages: 5) {}
    }
}
