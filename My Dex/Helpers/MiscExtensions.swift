//
//  MiscExtensions.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

// MARK: Pokemon Number Formatting
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

// MARK: Custom Errors
enum PokeApiError: Error {
  case pokemonOutOfBounds
}

extension PokeApiError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .pokemonOutOfBounds:
      return "Pokemon Id is out of bounds"
    }
  }
}

// MARK: Custom Colors
extension UIColor {
  static let primaryRed = UIColor(red: 0.91, green: 0.30, blue: 0.30, alpha: 1.00)
}
