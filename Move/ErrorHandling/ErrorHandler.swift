//
//  ErrorHandler.swift
//  Move
//
//  Created by Raul Pele on 02.09.2022.
//

import Foundation
import SwiftMessages

struct ErrorData {
    let title: String
    let subtitle: String
    
}

protocol ErrorHandler {
    func handle(error: ErrorData)
    func handle(error: Error, title: String)

}

extension ErrorHandler {
    func handle(error: Error, title: String) {
        if let apiError = error as? APIError {
            handle(error: .init(title: title, subtitle: apiError.message))
        }
    }
}

class SwiftMessagesErrorHandler: ErrorHandler {
    func handle(error: ErrorData) {

        let view = MessageView.viewFromNib(layout: .cardView)

        view.configureTheme(.error)
        view.configureContent(title: error.title, body: error.subtitle)
        view.button?.isHidden = true
        view.tapHandler = { _ in SwiftMessages.hide() }
        
        SwiftMessages.show(view: view)
    }
    
    
}

class ErrorToastViewModel: ObservableObject {
    @Published var error: ErrorData?
    
    func showError(error: ErrorData) {
        self.error = error
    }
    
    func hideError() {
        error = nil
    }
}

class MyErrorHandler: ErrorHandler {
    static var shared = MyErrorHandler()

    var viewModel = ErrorToastViewModel()
    
    func handle(error: ErrorData) {
        viewModel.showError(error: error)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.hideError()
        }
    }
    
    
}
