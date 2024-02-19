//
//  Array+Only.swift
//  Memorize
//
//  Created by Douglas Morais on 02/07/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
