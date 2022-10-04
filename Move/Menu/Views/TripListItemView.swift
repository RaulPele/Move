//
//  TripListItemView.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import SwiftUI

struct TripListItemView: View {
    let formattedTripData: FormattedTripData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment:.top, spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    Text("From")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)
                    Text(formattedTripData.startAddress)
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                        .frame(height: 40, alignment: .top)
                }
                .frame(width: UIScreen.main.bounds.width * 3/5, alignment: .leading)

                VStack(alignment: .leading, spacing: 0){
                    Text("Travel time")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)
                    Text("\(formattedTripData.travelTime.convertToHoursAndMinutesFormat()) min")
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

                    Text(formattedTripData.endAddress)
                        .font(.baiJamjureeBold(size: 14))
                        .foregroundColor(.primaryDark)
                        .frame(height: 40, alignment: .top)

                }
                .frame(width: UIScreen.main.bounds.width * 3/5, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Distance")
                        .font(.baiJamjureeMedium(size: 12))
                        .foregroundColor(.neutralGray)

                    Text("\(formattedTripData.distance.convertToKilometersFormat()) km")
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
            
            TripListItemView(formattedTripData: .init(id: "123123", startAddress: "aaaa", endAddress: "aaaa", travelTime: 1234, distance: 1234))
                .previewDevice(device)
        }
    }
}
