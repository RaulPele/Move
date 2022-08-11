//
//  FontExtensions.swift
//  Move
//
//  Created by Raul Pele on 11.08.2022.
//

import Foundation
import SwiftUI

extension Font {
    static func baiJamjureeBold(size: CGFloat) -> Font {
        return .custom("BaiJamjuree-Bold", size: size)
    }
    
    static func baiJamjureeRegular(size: CGFloat) -> Font {
        return .custom("BaiJamjuree-Regular", size: size)
    }
    
    static func baiJamjureeMedium(size: CGFloat) -> Font {
        return .custom("BaiJamjuree-Medium", size: size)
    }
    
    static func baiJamjureeLight(size: CGFloat) -> Font {
        return .custom("BaiJamjuree-Light", size: size)
    }
    
    static func baiJamjureeSemiBold(size: CGFloat) -> Font {
        return .custom("BaiJamjuree-SemiBold", size: size)
    }
}
