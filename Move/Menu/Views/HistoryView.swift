//
//  HistoryView.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import SwiftUI

struct HistoryView: View {
    let errorHandler: ErrorHandler
    let userService: UserService
    let onBackButtonClicked: () -> Void
    @StateObject private var viewModel: ViewModel
    
    init(errorHandler: ErrorHandler,
         userService: UserService,
         onBackButtonClicked: @escaping () -> Void) {
        self.errorHandler = errorHandler
        self.userService = userService
        self.onBackButtonClicked = onBackButtonClicked
        self._viewModel = .init(wrappedValue: .init(userService: userService))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            VStack(spacing: 44) {
                titleBarView
                
                ScrollView{
                    VStack(spacing: 12) {
                        ForEach(viewModel.trips, id: \.id) { formattedTripData in
                            TripListItemView(formattedTripData: formattedTripData)
                        }
                    }
                }
            }
            .padding(.top, 10)
            .padding([.horizontal, .bottom], 24)
        }
    }
}

private extension HistoryView {
    var titleBarView: some View {
        HStack(spacing: 0) {
            Button {
                onBackButtonClicked()
            } label: {
                Image("chevron-left")
            }
            
            Spacer()
            
            Text("History")
                .foregroundColor(.primaryDark)
                .font(.heading3())
            
            Spacer()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            HistoryView(errorHandler: SwiftMessagesErrorHandler(), userService: UserAPIService(sessionManager: .init()), onBackButtonClicked: {})
                .previewDevice(device)
        }
    }
}
