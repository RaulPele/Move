//
//  ScooterMapViewModel.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import Foundation
import MapKit
import SwiftUI

class ScooterMapViewModel: NSObject, ObservableObject {
    let scooterService: ScooterService
    let geocoderProxy = GeocoderProxy()
    
    var onScooterSelected: (Scooter) -> Void = { _ in }
    var onScooterDeselected: () -> Void = { }
    var onMapLocationChanged: (String) -> Void = { _ in}
    
    private var locationManager: CLLocationManager? = nil
    private var userLocation: CLLocation? = nil
    private var previousMapCenter: CLLocation?
    private var currentMapCenter: CLLocation?
    
    @Published var region = MKCoordinateRegion(center: Coordinates.ClujNapoca, latitudinalMeters: 4000, longitudinalMeters: 4000)
    @Published var tracking = false
    
    
    var scooterAnnotations: [ScooterAnnotation] = [] {
        didSet {
            refreshScooterList()
        }
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.setRegion(region, animated: true)
        mapView.showsCompass = false
        
        return mapView
    }()
    
    init(scooterService: ScooterService) {
        self.scooterService = scooterService
    }
    
    var isTrackingUserLocation: Bool {
        return tracking
    }
    
    func refreshScooterList() {
//        if self.mapView.annotations.count - 1 != self.scooterAnnotations.count {
        
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(self.scooterAnnotations)
//        }
     }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location services are not enabled. Go to settings to turn them on")
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            onMapLocationChanged("Location services is restricted")
        case .denied:
            onMapLocationChanged("Allow location")
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
        @unknown default:
            break
        }
    }
    
    func centerMapOnUserLocation() {
        region = MKCoordinateRegion(center: userLocation?.coordinate ?? Coordinates.ClujNapoca, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
    
    func toggleUserLocationTracking() {
        tracking.toggle()

        if tracking {
            self.mapView.setUserTrackingMode(.followWithHeading, animated: true)
        } else {
            self.mapView.setUserTrackingMode(.none, animated: true)
        }
    }
    
    func getMapLocationString() {
        guard let currentMapCenter = currentMapCenter else {
            return
        }
        
        geocoderProxy.reverseGeocodeLocation(location: currentMapCenter) { [weak self] placemarks, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                print("Error decoding location: \(error.localizedDescription)")
                return
            }
            
            guard let placemarks = placemarks,
                let placemark = placemarks.first else {
                return
            }
            
            let city = placemark.locality ?? "Couldn't find user city"
            self.onMapLocationChanged(city)
        }
    }
    
    func addUserLocationAnnotation() {
        mapView.showsUserLocation = true
        
    }
}


extension ScooterMapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?

        
        if annotation is MKUserLocation {
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifiers.userAnnotation.rawValue)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifiers.userAnnotation.rawValue)
                annotationView!.image = UIImage(named: self.userLocation == nil ?
                                                "user-location-arrow-unauthorized" :
                                                    "user-location-arrow-authorized")
            }
            
            annotationView!.tintColor = .blue
        } else if annotation is ScooterAnnotation {

            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifiers.scooterAnnotation.rawValue)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifiers.scooterAnnotation.rawValue)
                annotationView!.image = UIImage(named: "unselected-pin-fill")

            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let scooterAnnotation = view.annotation as? ScooterAnnotation
        
        guard let scooterAnnotation = scooterAnnotation else {
            return
        }
        onScooterSelected(scooterAnnotation.scooter)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        onScooterDeselected()
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if mode == .none {
            tracking = false
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let mapCenter = mapView.centerCoordinate
        previousMapCenter = CLLocation(latitude: mapCenter.latitude, longitude: mapCenter.longitude)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapCenter = mapView.centerCoordinate
        currentMapCenter = CLLocation(latitude: mapCenter.latitude, longitude: mapCenter.longitude)
        
        let distanceScrolled = currentMapCenter!.distance(from: previousMapCenter!)
        if distanceScrolled > 500 {
            getMapLocationString()
        }
        
    }
}

extension ScooterMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let shouldCenterOnUserLocation = self.userLocation == nil
        guard let lastLocation = locations.last else {
            return
        }
        self.userLocation = lastLocation
        if shouldCenterOnUserLocation {
            withAnimation {
                self.centerMapOnUserLocation()
                self.addUserLocationAnnotation()
                self.getMapLocationString()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to retreive location: \(error.localizedDescription)")
    }
}
