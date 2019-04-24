//
//  Pokemon.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

struct Pokemon {
  let name: String
  let id: Int
  let height: Int
  let weight: Int
  let types: [Type]
  let imageURL: String
}

extension Pokemon: Decodable {
  enum CodingKeys: String, CodingKey {
    case id
    case height
    case weight
    // Nested array
    case types
    enum TypeKeys: String, CodingKey {
      case type
    }
    // Nested object
    case species
    enum SpeciesKeys: String, CodingKey {
      case name
    }
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let speciesContainer = try container.nestedContainer(keyedBy: CodingKeys.SpeciesKeys.self, forKey: .species)
    self.name = try speciesContainer.decode(String.self, forKey: .name)
    
    self.id = try container.decode(Int.self, forKey: .id)
    self.height = try container.decode(Int.self, forKey: .height)
    self.weight = try container.decode(Int.self, forKey: .weight)
    
    var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
    var types = [Type]()
    while !typesContainer.isAtEnd {
      let typeContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeKeys.self)
      let type = try typeContainer.decode(Type.self, forKey: .type)
      types.append(type)
    }
    self.types = types
    
    self.imageURL = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id.formattedPokemonId).png"
  }
}

struct Type {
  let name: String
  let url: String
}

extension Type: Decodable {
  enum CodingKeys: String, CodingKey {
    case name
    case url
  }
}
