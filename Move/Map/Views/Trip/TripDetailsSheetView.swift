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
    let onEndRide: () -> Void
    
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
            
            Text("\(viewModel.trip?.distance.convertToKilometersFormat() ?? "0.0") ")
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
                if viewModel.scooter!.isLocked {
                    viewModel.unlockRide {
                        
                    } onError: { error in
                        errorHandler.handle(error: error, title: "Couldn't lock scooter!")
                    }
                } else {
                    viewModel.lockRide {
                        
                    } onError: { error in
                        errorHandler.handle(error: error, title: "Couldn't unlock scooter!")
                    }

                }

            } label: {
                HStack(spacing: 4) {
                    Image(viewModel.scooter!.isLocked ? "open-lock-icon" : "lock-icon")
                    Text(viewModel.scooter!.isLocked ? "Unlock" : "Lock")
                }
                .frame(maxWidth: .infinity)
                .opacity(viewModel.isWaitingForLock ? 0 : 1)

            }
            .buttonStyle(.transparentButton)
            .hasLoadingBehaviour(showLoadingIndicator: $viewModel.isWaitingForLock, indicatorColor: .accent)
            .disabled(viewModel.isWaiting)

            Button {
                viewModel.endRide {
                    onEndRide()
                } onError: { error in
                    errorHandler.handle(error: error, title: "Couldn't end ride!")
                }

            } label: {
                Text("End ride")
                    .frame(maxWidth: .infinity)
                    .opacity(viewModel.isWaitingForEndRide ? 0 : 1)

            }
            .buttonStyle(.filledButton)
            .hasLoadingBehaviour(showLoadingIndicator: $viewModel.isWaitingForEndRide, indicatorColor: .accent)
            .disabled(viewModel.isWaiting)
        }
    }
}
//struct TripDetailsSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(devices) { device in
//            Sheet(showSheet: .constant(true)) {
//                TripDetailsSheetView(viewModel: .init(), errorHandler: SwiftMessagesErrorHandler(), onEndRide: {_, _ in })
//            }
//            .previewDevice(device)
//
//        }
//    }
//}
