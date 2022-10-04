//
//  MenuViewModel.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import Foundation

extension MenuView {
    class ViewModel: ObservableObject {
        @Published var numberOfTrips: Int = 0
        @Published var user: User?
        let userService: UserService
        let authenticationService: AuthenticationService
        
        
        init(userService: UserService, authenticationService: AuthenticationService) {
            self.userService = userService
            self.authenticationService = authenticationService
        }
        
        func getUserDetails(onError: @escaping (Error) -> Void) {
            userService.getUser { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let userDetails):
                    self.user = userDetails.user
                    self.numberOfTrips = userDetails.numberOfTrips
                    
                case .failure(let error):
                    onError(error)
                }
            }
        }
        
        func logout(onLogout: @escaping () -> Void) {
            authenticationService.logout { result in
                switch result {
                case .success(_):
                    onLogout()
                case .failure(let failure):
                    print("Error logging out")
                }
            }
        }
    }
}
