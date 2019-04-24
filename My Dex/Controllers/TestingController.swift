//
//  TestingController.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class TestingController: UITableViewController {
  var pokedex: [Pokemon] = [Pokemon]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchPokemon()
  }
}

private extension TestingController {
  func fetchPokemon() {
    PokeApi.shared.fetchPokemon(toId: 807) { (pList) in
      self.pokedex = pList
      self.fetchedPokemon()
    }
  }
  
  func fetchedPokemon() {
    // Sort the pokemon by id
    pokedex.sort { (p1, p2) -> Bool in
      return p1.id < p2.id
    }
    
    pokedex.forEach({print("\($0.id.formattedPokemonId) - \($0.name.capitalized)")})
  }
}
