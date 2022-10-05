//
//  HistoryViewModel.swift
//  Move
//
//  Created by Raul Pele on 05.10.2022.
//

import Foundation
import MapKit

extension HistoryView {
    class ViewModel: ObservableObject {
        let userService: UserService
        @Published var trips = [FormattedTripData]()
        
        init(userService: UserService) {
            self.userService = UserMockedService()
        }
        
        func getHistory(onError: @escaping (Error) -> Void) {
            userService.getUserTrips { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let trips):
                    self.trips = trips

                case .failure(let error):
                    onError(error)
                }
            }
        }
//
//        private func getFormattedTrip(_ trip: Trip, completionHandler: @escaping (Result<FormattedTripData, Error>) -> Void) {
//
//            getReadableLocation(location: trip.startLocation) { startAddress in
//                getReadableLocation(location: trip.endLocation) { endAddress in
//                    let formattedTrip: FormattedTripData = .init(id: trip.id, startAddress: startAddress, endAddress: endAddress, travelTime: trip.duration, distance: trip.distance)
//
//                }
//            }
//        }
//
//        private func getReadableLocation(location: CLLocation, completionHandler: @escaping (String) -> Void) {
//            geocoderProxy.reverseGeocodeLocation(location: location) { placemarks, error in
//                if let error = error {
////                    completionHandler("error")
//                    return
//                }
//
//                guard let placemark = placemarks?.first else { return }
//
//                guard let street = placemark.thoroughfare,
//                      let number = placemark.subThoroughfare else {
//                    return
//                }
//
//                let address = "Str. \(street) \(number)"
//                completionHandler(address)
//
//            }
//
//        }
    }
}
