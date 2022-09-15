//
//  BatteryView.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import SwiftUI

struct BatteryView: View {
    let batteryPercentage: Int
    
    var body: some View {
        HStack(spacing: 7) {
            
            batteryImage
            
            Text("\(batteryPercentage)%")
                .foregroundColor(.primaryDark)
                .font(.body2())
        }
    }
}

private extension BatteryView {
    @ViewBuilder
    var batteryImage: some View {
        switch batteryPercentage {
        case 0: //and not charging
            Image("battery-drained")
        case 1..<20:
            Image("battery-low")
        case 20..<40:
            Image("battery-20")
        case 40..<60:
            Image("battery-40")
        case 60..<80:
            Image("battery-60")
            
        case 80..<95:
            Image("battery-80")
            
        case 95...100:
            Image("battery-full")
        default:
            EmptyView()
        }
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(batteryPercentage: 82)
    }
}
