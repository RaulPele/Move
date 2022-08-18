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
    
    static func heading1() -> Font {
        return baiJamjureeBold(size: 32)
    }
    
    static func heading2() -> Font {
        return baiJamjureeMedium(size: 20)
    }
    
    static func heading3() -> Font {
        return baiJamjureeSemiBold(size: 17)
    }
    
    static func heading4() -> Font {
        return baiJamjureeMedium(size: 16)
    }
    
    static func button1() -> Font {
        return baiJamjureeBold(size: 16)
    }
    
    static func button2() -> Font {
        return baiJamjureeMedium(size: 14)
    }
    
    static func caption1() -> Font {
        return baiJamjureeSemiBold(size: 12)
    }
    
    static func caption2() -> Font {
        return baiJamjureeRegular(size: 12)
    }
    
    static func body1() -> Font {
        return baiJamjureeMedium(size: 16)
    }
    
    static func body2() -> Font {
        return baiJamjureeMedium(size: 14)
    }
    
    static func smallText() -> Font {
        return baiJamjureeRegular(size: 12)
    }
}
