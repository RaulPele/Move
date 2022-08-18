//
//  PreviewDevices.swift
//  Move
//
//  Created by Raul Pele on 18.08.2022.
//

import Foundation
import SwiftUI

extension PreviewDevice: Identifiable {
    public var id: String {self.rawValue}
}

extension PreviewProvider {
    static var iPhone8: PreviewDevice {
        return PreviewDevice(rawValue: "iPhone 8")
    }
    
    static var iPhone13Pro: PreviewDevice {
        return PreviewDevice(rawValue: "iPhone 13 Pro")
    }
    
    static var devices: [PreviewDevice] {
        return [iPhone8, iPhone13Pro]
    }
}
