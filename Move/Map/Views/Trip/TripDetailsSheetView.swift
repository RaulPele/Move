//
//  TripDetailsSheetView.swift
//  Move
//
//  Created by Raul Pele on 02.10.2022.
//

import SwiftUI

struct TripDetailsSheetView: View {
    @ObservedObject var viewModel: TripDetailsViewModel
    let errorHandler: ErrorHandler
    let onEndRide: (Scooter, Trip) -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Trip Details")
                    .foregroundColor(.primaryDark)
                    .font(.baiJamjureeSemiBold(size: 16))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .padding(.bottom, 16)
                
                HStack(spacing: 0) {
                    BatteryView(batteryPercentage: viewModel.scooter?.batteryPercentage ?? 0)
                    Spacer()
                    
                }
                .padding(.bottom, 24)
                tripInformationView
                    .padding(.bottom, 36)
                scooterButtonsView
                
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 32)
            .foregroundColor(.neutralWhite)
            .ignoresSafeArea())
    }
}

private extension TripDetailsSheetView {
    var travelTimeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image("timer-icon")
                Text("Travel time")
                    .foregroundColor(.primaryDark.opacity(0.6))
                    .font(.heading4())
            }
            
            Text("\(viewModel.duration.convertToHoursAndMinutesFormat()) ")
                .foregroundColor(.primaryDark)
                .font(.heading1())
            
            + Text("min")
                .foregroundColor(.primaryDark)
                .font(.heading3())
        }
    }
    var distanceView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image("distance-icon")
                Text("Distance")
                    .foregroundColor(.primaryDark.opacity(0.6))
                    .font(.heading4())
            }
            
            Text("2.7 ")
                .foregroundColor(.primaryDark)
                .font(.heading1())
            
            + Text("km")
                .foregroundColor(.primaryDark)
                .font(.heading3())
        }
    }
    
    var tripInformationView: some View {
        HStack(spacing: 55) {
            travelTimeView
            distanceView
        }
    }
    
    var scooterButtonsView: some View {
        HStack(spacing: 21) {
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    Image("lock-icon")
                    Text("Lock")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.transparentButton)
            
            Button {
                viewModel.endRide { scooter, trip in
                    onEndRide(scooter, trip)
                } onError: { error in
                    errorHandler.handle(error: error, title: "Couldn't end ride!")
                }

            } label: {
                Text("End ride")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.filledButton)
        }
    }
}
struct TripDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            Sheet(showSheet: .constant(true)) {
                TripDetailsSheetView(viewModel: .init(), errorHandler: SwiftMessagesErrorHandler(), onEndRide: {_, _ in })
            }
            .previewDevice(device)

        }
    }
}
