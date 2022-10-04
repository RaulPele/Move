//
//  TripListItemView.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import SwiftUI

struct TripListItemView: View {
    let trip: Trip
    
    var body: some View {
//        HStack(spacing: 0) {
//            VStack(alignment:.leading, spacing: 8) {
//                VStack(alignment: .leading, spacing: 0){
//                    Text("From")
//                        .font(.baiJamjureeMedium(size: 12))
//                        .foregroundColor(.neutralGray)
//                    Text("9776 Gutkowski Shores Suite 420")
//                        .font(.baiJamjureeBold(size: 14))
//                        .foregroundColor(.primaryDark)
//                }
//
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("To")
//                        .font(.baiJamjureeMedium(size: 12))
//                        .foregroundColor(.neutralGray)
//
//                    Text("599 Ebert Lock")
//                        .font(.baiJamjureeBold(size: 14))
//                        .foregroundColor(.primaryDark)
//                }
//            }
//            .frame(width: UIScreen.main.bounds.width * 3/5, alignment: .leading)
//
//            VStack(alignment: .leading, spacing: 8) {
//                VStack(alignment: .leading, spacing: 0){
//                    Text("Travel time")
//                        .font(.baiJamjureeMedium(size: 12))
//                        .foregroundColor(.neutralGray)
//                    Text("00:42 min")
//                        .font(.baiJamjureeBold(size: 14))
//                        .foregroundColor(.primaryDark)
//                }
//
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Distance")
//                        .font(.baiJamjureeMedium(size: 12))
//                        .foregroundColor(.neutralGray)
//
//                    Text("7.8 km")
//                        .font(.baiJamjureeBold(size: 14))
//                        .foregroundColor(.primaryDark)
//                }
//            }
//
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(20)
//        .background(RoundedRectangle(cornerRadius: 29)
//            .stroke(Color.primaryDark, lineWidth: 1)
//            .foregroundColor(.clear))
        
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment:.top, spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    Text("From")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)
                    Text("9776 Gutkowski Shores Suite 420")
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                        .frame(height: 40, alignment: .top)
                }
                .frame(width: UIScreen.main.bounds.width * 3/5, alignment: .leading)
//                Spacer()

                VStack(alignment: .leading, spacing: 0){
                    Text("Travel time")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)
                    Text("00:42 min")
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            HStack(alignment:.top, spacing: 0){
                VStack(alignment: .leading, spacing: 0) {
                    Text("To")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)

                    Text("599 Ebert Lock")
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                        .frame(height: 40, alignment: .top)

                }
                .frame(width: UIScreen.main.bounds.width * 3/5, alignment: .leading)
                
//                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Distance")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)

                    Text("7.8 km")
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 18)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 29)
            .stroke(Color.primaryDark, lineWidth: 1)
            .foregroundColor(.clear))
        .background(alignment:.leading) {
            RoundedRectangle(cornerRadius: 29)
                .foregroundColor(.neutralLightPurple.opacity(0.2))
                .frame(width: UIScreen.main.bounds.width * 3/5 + 20, alignment: .leading)
        }
        
        
        
    }
}

struct TripListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            
            TripListItemView(trip: .init(startLocation: .init(latitude: 46.7535304, longitude: 23.5842638), endLocation: .init(latitude: 46.7535304, longitude: 23.5842638), userId: "12341242", scooterId: "qweq12312", status: .ended, distance: 3500, duration: 7000, allLocations: .init(), cost: 1234))
                .previewDevice(device)
        }
    }
}
