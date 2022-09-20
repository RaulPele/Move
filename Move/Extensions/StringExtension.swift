//
//  StringExtension.swift
//  Move
//
//  Created by Raul Pele on 20.09.2022.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
