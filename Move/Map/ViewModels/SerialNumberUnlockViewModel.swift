//
//  SerialNumberUnlockViewModel.swift
//  Move
//
//  Created by Raul Pele on 20.09.2022.
//

import Foundation
//import SwiftUI

extension SerialNumberUnlockView {
    class SerialNumberUnlockViewModel: ObservableObject {
        @Published var text: String = ""
        @Published var isLoading = false
        let scooter: Scooter
        
        init(scooter: Scooter) {
            self.scooter = scooter
        }
        
        func validatePin(onSuccess: () -> Void, onError: () -> Void) {
            if text.count == 4 {
                onSuccess()
            } else {
                onError()
            }
        }
        
        func unlock(onUnlockedSuccessfuly: @escaping () -> Void, onError: @escaping (Error) -> Void) {
            print("Unlocked scooter")
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else {
                    return
                }
                onUnlockedSuccessfuly()
                self.isLoading = false
            }
        }
    }
}
