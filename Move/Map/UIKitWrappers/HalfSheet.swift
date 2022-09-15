//
//  HalfSheet.swift
//  Move
//
//  Created by Raul Pele on 15.09.2022.
//

import Foundation
import SwiftUI

struct HalfSheet<Content>: UIViewControllerRepresentable where Content: View {
    var sheetView: Content
    
    @Binding var showSheet: Bool
    var onDismiss: () -> Void
        
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType,
                                context: Context) {
        if showSheet {
            let sheetController = MySheetHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
            
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheet
        init(parent: HalfSheet) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onDismiss()
        }
    }
}
