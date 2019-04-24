//
//  MiscExtensions.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

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
