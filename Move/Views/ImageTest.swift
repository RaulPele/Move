//
//  ImageTest.swift
//  Move
//
//  Created by Raul Pele on 31.08.2022.
//

import SwiftUI

struct ImageTest: View {
    var body: some View {
        VStack {
            Color.blue
                .frame(height: 100)
            
            Color.red
            
            Color.green
                .frame(height: 200)
        }
    }
}

struct ImageTest_Previews: PreviewProvider {
    static var previews: some View {
        ImageTest()
    }
}
