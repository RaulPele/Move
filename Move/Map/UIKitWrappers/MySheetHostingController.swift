//
//  ScooterSheetHostingController.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import Foundation

class MySheetHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        
        if let presentationController = presentationController as?
            UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            presentationController.prefersGrabberVisible = true
            presentationController.preferredCornerRadius = 32
        }
    }
}
