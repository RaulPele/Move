//
//  TripDetailsFullScreenView.swift
//  Move
//
//  Created by Raul Pele on 02.10.2022.
//

import SwiftUI

struct TripDetailsFullScreenView: View {
    @ObservedObject var viewModel: TripDetailsViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            VStack(spacing: 44) {
                titleBarView
                tripInformationView
                buttonsView
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
    
    var batteryView: some View {
       return MetricsCardView(titleView: {
            HStack(spacing: 7) {
                Image("battery-60")
                Text("Battery")
                    .font(.body1())
                    .foregroundColor(.neutralLightPurple)
            }
       }, metricsValue: "\(viewModel.scooter?.batteryPercentage ?? 0)%")
        
    }
    
    var travelTimeView: some View {
       return MetricsCardView(titleView: {
           HStack(spacing: 7) {
               Image("timer-icon")
               Text("Travel time")
                   .font(.body1())
                   .foregroundColor(.neutralLightPurple)
           }
       }, metricsValue: viewModel.duration.convertToHoursMinutesSecondsFormat())
    }
    
    var distanceView: some View {
        return MetricsCardView(titleView: {
            HStack(spacing: 7) {
                Image("distance-icon")
                Text("Distance")
                    .font(.body1())
                    .foregroundColor(.neutralLightPurple)
            }
        }, metricsValue: viewModel.trip?.distance.convertToKilometersFormat() ?? "0",
        metricsDescription: "km")
    }
    
    var tripInformationView: some View {
        VStack(spacing: 24) {
            batteryView
            travelTimeView
            distanceView
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 21) {
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    Image("lock-icon")
//                        .frame(width: 24, height: 24)
                    Text("Lock")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
            
            Button {
                
            } label: {
                Text("End ride")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
        }
    }
}

struct MetricsCardView<Content>: View where Content: View {
    @ViewBuilder let titleView: () -> Content
    let metricsValue: String
    let metricsDescription: String?
    
    init(@ViewBuilder titleView: @escaping () -> Content,
         metricsValue: String,
         metricsDescription: String? = nil
    ) {
        self.titleView = titleView
        self.metricsValue = metricsValue
        self.metricsDescription = metricsDescription
    }
    
    var body: some View {
        VStack(spacing: 0) {
            titleView()
                .padding(.bottom, 12)

            
            Text(metricsValue)
                .foregroundColor(.primaryDark)
                .font(.baiJamjureeBold(size: 44))
                .padding(.bottom, metricsDescription == nil ? 12: 0)
            
            if let metricsDescription = self.metricsDescription {
                Text(metricsDescription)
                    .foregroundColor(.primaryDark)
                    .font(.body1())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        .padding(.bottom, metricsDescription != nil ? 28 : 40)
        
        .padding(.horizontal, 20)
        
        .background(RoundedRectangle(cornerRadius: 29)
            .stroke(Color.borderGray, lineWidth: 1))
    }
    
}
  
struct TestSheet: View {
    //just for preview purposes
    var viewModel = TripDetailsViewModel()
    
    init() {
        viewModel.scooter = .init(id: "1234", scooterNumber: 1234, bookedStatus: .booked, lockedStatus: .locked, batteryPercentage: 85, location: .init())
        viewModel.trip = .init(id: "1232", startLocation: .init(), endLocation: .init(), userId: "121312412", scooterId: "123123", status: .inProgress, distance: 3200, duration: 5000, allLocations: .init(), cost: 235)
    }
    
    var body: some View {
        return TripDetailsFullScreenView(viewModel: viewModel)
    }
}

struct TripDetailsFullScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(devices) { device in
            TestSheet()
                .previewDevice(device)
        }
    }
}
