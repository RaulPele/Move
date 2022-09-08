//
//  ScooterMapViewModel.swift
//  Move
//
//  Created by Raul Pele on 07.09.2022.
//

import Foundation
import MapKit

class ScooterMapViewModel: NSObject, ObservableObject {
    let scooterService: ScooterService
    
    var centerCoordinate = Coordinates.ClujNapoca
    var scooters: [ScooterAnnotation] = [] {
        didSet {
            refreshScooterList()
        }
    }
    
    init(scooterService: ScooterService) {
        self.scooterService = scooterService
    }
    
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.setRegion(.init(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: false)
        return mapView
    }()
    
    func refreshScooterList() {
         mapView.removeAnnotations(mapView.annotations)
         mapView.addAnnotations(scooters)
     }
}

extension ScooterMapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "scooterAnnotation")
      
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "unselected-pin-fill")
        
        return annotationView
    }
    
    
    
}
