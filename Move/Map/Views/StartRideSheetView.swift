//
//  ScooterDetailsSheetView.swift
//  Move
//
//  Created by Raul Pele on 22.09.2022.
//

import SwiftUI
import MapKit
struct StartRideSheetView: View {
    let errorHandler: ErrorHandler
    let onStartRide: (Scooter, Trip) -> Void
    
    @StateObject private var viewModel: StartRideSheetViewModel
    
    init(errorHandler: ErrorHandler, scooter: Scooter, userLocation: CLLocation, rideService: RideService, onStartRide: @escaping (Scooter, Trip) -> Void) {
        self.errorHandler = errorHandler
        self.onStartRide = onStartRide
        self._viewModel = .init(wrappedValue: .init(scooter: scooter, userLocation: userLocation, rideService: rideService))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 25) {
                HStack(alignment: .center, spacing: 0) {
                    scooterDetailsView
                    Spacer()
                    scooterImageView
                }

                Button {
                    viewModel.startRide { scooter, trip in
                        onStartRide(scooter, trip)
                    } onError: { error in
                        errorHandler.handle(error: error, title: "Cannot start ride!")
                    }

                } label: {
                    Text("Start ride")
                        .frame(maxWidth:.infinity)
                }
                .buttonStyle(.filledButton)
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            .padding(.bottom, 24)
        }
        .background(RoundedRectangle(cornerRadius: 32)
            .foregroundColor(.neutralWhite)
            .ignoresSafeArea())
    }
}

private extension StartRideSheetView {
    var scooterDetailsView: some View {
        VStack(alignment: .leading,spacing: 4 ) {
            Text("Scooter")
                .font(.heading4())
                .foregroundColor(.primaryDark.opacity(0.6))
            
            Text(verbatim: "#\(viewModel.scooter.scooterNumber)")
                .font(.heading1())
                .foregroundColor(.primaryDark)
            
            BatteryView(batteryPercentage: viewModel.scooter.batteryPercentage)
        }
    }
    
    var scooterImageView: some View {
        ZStack {
            Image("SheetScooterImage")
                .resizable()
                .scaledToFit()
            
            Image("SheetScooterRectangleBackground")
        }
    }
}

struct ScooterDetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            ZStack {
                Color.red
                
            }
            .overlay {
                Sheet(showSheet: .constant(true)) {
                    StartRideSheetView(errorHandler: SwiftMessagesErrorHandler(), scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .available, lockedStatus: .unlocked, batteryPercentage: 82, location: .init()), userLocation: .init(), rideService: RideAPIService(sessionManager: SessionManager()), onStartRide: { _, _ in })
                }
            }
            .previewDevice(device)
        }
    }
}
