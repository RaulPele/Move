//
//  ContentView.swift
//  Move
//
//  Created by Raul Pele on 09.08.2022.
//

import SwiftUI

struct ContentView: View {
    let errorHandler: ErrorHandler = SwiftMessagesErrorHandler()
    
    var body: some View {
//        MainCoordinatorView(errorHandler: errorHandler)
        MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
