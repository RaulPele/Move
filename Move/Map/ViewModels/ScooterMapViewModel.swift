//
//  ScooterMapViewModel.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import Foundation
import MapKit
import SwiftUI

class ScooterMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let scooterService: ScooterService
    
    var onScooterSelected: (Scooter) -> Void = { _ in }
    var onScooterDeselected: () -> Void = { }
    var onUserTrackingDisabled: () -> Void = { }
    
    private var locationManager: CLLocationManager? = nil
    @Published var region = MKCoordinateRegion(center: Coordinates.ClujNapoca, latitudinalMeters: 4000, longitudinalMeters: 4000)
    
    
    var scooterAnnotations: [ScooterAnnotation] = [] {
        didSet {
            refreshScooterList()
        }
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
        mapView.showsCompass = false
//        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: didDragMap(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>))
//        mapView.addGestureRecognizer(mapDragRecognizer)
        
        return mapView
    }()
    
    init(scooterService: ScooterService) {
        self.scooterService = scooterService
    }
    
    func refreshScooterList() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(self.scooterAnnotations)
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
            print("Location services is restricted")
        case .denied:
            print("Allow location services")
            
        case .authorizedAlways, .authorizedWhenInUse:
            centerMapOnUserLocation()
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func centerMapOnUserLocation() {
        guard let locationManager = locationManager,
        let location = locationManager.location else {
            print("location not initialized")
            return
        }

        region = MKCoordinateRegion(center: location.coordinate, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
}

extension ScooterMapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKAnnotationView()

        if annotation is MKUserLocation {
            annotationView = MKUserLocationView(annotation: annotation, reuseIdentifier: "userAnnotation")
            annotationView.tintColor = .blue
        } else if annotation is ScooterAnnotation {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "scooterAnnotation")
            annotationView.image = UIImage(named: "unselected-pin-fill")
            annotationView.canShowCallout = false
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
    
    //TODO: look into it
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if mode == .none {
            onUserTrackingDisabled()
        }
    }
}

