//
//  PokedexCollectionController.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class PokedexCollectionController: BaseCollectionView {
  private let cvPadding: CGFloat = 16
  
  private var pokedexEntries = [Pokemon]()
  
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
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width-(cvPadding*3)) / 2
    let height = round((width * 1.37614679) * 2) / 2
    print("\(width) x \(height)")
    return .init(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: cvPadding, left: cvPadding, bottom: 0, right: cvPadding)
  }
}
