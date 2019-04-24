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
  // UI
  static let primaryRed = UIColor(red: 0.91, green: 0.30, blue: 0.30, alpha: 1.00)
  static let primaryRedLight = UIColor(red: 0.96, green: 0.39, blue: 0.39, alpha: 1.00)
  static let cardBackground = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
  static let imageBackground = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
  static let textBlack = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
  static let textLight = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1.00)
  // Pokemon types
  static let typeNormal = UIColor(red: 0.67, green: 0.67, blue: 0.60, alpha: 1.00)
  static let typeFire = UIColor(red: 1.00, green: 0.27, blue: 0.13, alpha: 1.00)
  static let typeWater = UIColor(red: 0.21, green: 0.60, blue: 1.00, alpha: 1.00)
  static let typeElectric = UIColor(red: 1.00, green: 0.80, blue: 0.20, alpha: 1.00)
  static let typeGrass = UIColor(red: 0.47, green: 0.80, blue: 0.33, alpha: 1.00)
  static let typeIce = UIColor(red: 0.40, green: 0.80, blue: 1.00, alpha: 1.00)
  static let typeFighting = UIColor(red: 0.73, green: 0.33, blue: 0.27, alpha: 1.00)
  static let typePoison = UIColor(red: 0.67, green: 0.33, blue: 0.60, alpha: 1.00)
  static let typeGround = UIColor(red: 0.87, green: 0.73, blue: 0.33, alpha: 1.00)
  static let typeFlying = UIColor(red: 0.54, green: 0.60, blue: 1.00, alpha: 1.00)
  static let typePsychic = UIColor(red: 1.00, green: 0.33, blue: 0.60, alpha: 1.00)
  static let typeBug = UIColor(red: 0.67, green: 0.73, blue: 0.14, alpha: 1.00)
  static let typeRock = UIColor(red: 0.73, green: 0.67, blue: 0.40, alpha: 1.00)
  static let typeGhost = UIColor(red: 0.40, green: 0.40, blue: 0.73, alpha: 1.00)
  static let typeDragon = UIColor(red: 0.47, green: 0.40, blue: 0.93, alpha: 1.00)
  static let typeDark = UIColor(red: 0.47, green: 0.33, blue: 0.27, alpha: 1.00)
  static let typeSteel = UIColor(red: 0.67, green: 0.67, blue: 0.73, alpha: 1.00)
  static let typeFairy = UIColor(red: 0.93, green: 0.60, blue: 0.93, alpha: 1.00)
}
