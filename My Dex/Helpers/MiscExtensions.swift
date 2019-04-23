//
//  MiscExtensions.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

extension Int {
  var formattedPokemonId: String {
    return NumberFormatter.pokemonIdFormatter.string(from: self as NSNumber)!
  }
}

extension NumberFormatter {
  static let pokemonIdFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.minimumIntegerDigits = 3
    nf.maximumFractionDigits = 0
    nf.allowsFloats = false
    return nf
  }()
}
