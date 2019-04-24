//
//  PokedexCollectionController.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class PokedexCollectionController: BaseCollectionView {
  var pokedexEntries = [Pokemon]()
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "My Dex"
    collectionView.backgroundColor = .white
    collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: PokedexCell.reuseIdentifier)
    fetchPokemon()
  }
}

private extension PokedexCollectionController {
  func fetchPokemon() {
    PokeApi.shared.fetchPokemon(toId: PokeApi.shared.maxPokemonId) { (pokemon) in
      self.pokedexEntries = pokemon
      self.fetchedPokemon()
    }
  }
  
  func fetchedPokemon() {
    pokedexEntries.sort { (p1, p2) -> Bool in
      return p1.id < p2.id
    }
    collectionView.reloadData()
  }
}

extension PokedexCollectionController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokedexEntries.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.reuseIdentifier, for: indexPath) as! PokedexCell
    cell.pokemon = pokedexEntries[indexPath.item]
    return cell
  }
}

extension PokedexCollectionController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return .init(width: 100, height: 100)
//  }
}
