//
//  PokedexCollectionController.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class PokedexCollectionController: BaseCollectionView {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private let cvPadding: CGFloat = 16
  
  private var pokedexEntries = [Pokemon]()
  
  private var filteredPokedexEntries = [Pokemon]()
  private var searchActive: Bool = false
  private var searchTimer: Timer?
  
  private let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView()
    aiv.hidesWhenStopped = true
    aiv.style = .whiteLarge
    aiv.color = .primaryRed
    aiv.startAnimating()
    return aiv
  }()
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "My Dex"
    collectionView.backgroundColor = .white
    collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: PokedexCell.reuseIdentifier)
    extendedLayoutIncludesOpaqueBars = true
    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()
    fetchPokemon()
    setupSearchBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationItem.hidesSearchBarWhenScrolling = true
  }
}

private extension PokedexCollectionController {
  func fetchPokemon() {
    PokeApi.shared.fetchPokemon(toId: PokeApi.shared.maxPokemonId) { (pokemon) in
      self.activityIndicatorView.stopAnimating()
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
  
  func setupSearchBar() {
    definesPresentationContext = true
    searchController.searchBar.tintColor = .white
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false   // Allows interaction in background view
    searchController.delegate = self
    searchController.searchBar.delegate = self
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

extension PokedexCollectionController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchActive ? filteredPokedexEntries.count : pokedexEntries.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.reuseIdentifier, for: indexPath) as! PokedexCell
    
    if searchActive {
      cell.pokemon = filteredPokedexEntries[indexPath.item]
    } else {
      cell.pokemon = pokedexEntries[indexPath.item]
    }
    
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PokedexCollectionController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width-(cvPadding*3)) / 2
    let height = round((width * 1.37614679) * 2) / 2
//    print("\(width) x \(height)")
    return .init(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: cvPadding, left: cvPadding, bottom: 0, right: cvPadding)
  }
}

// MARK: SearchBar
extension PokedexCollectionController: UISearchControllerDelegate {
  func didPresentSearchController(_ searchController: UISearchController) {
    searchActive = true
  }
}

extension PokedexCollectionController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false
    filteredPokedexEntries = [Pokemon]()
    collectionView.reloadData()
//    self.dismiss(animated: true, completion: nil)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchTimer?.invalidate()
    searchTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { (_) in
      self.filterPokemon(withString: searchText)
      self.collectionView.reloadData()
    })
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchString = searchBar.text {
      filterPokemon(withString: searchString)
    }
    collectionView.reloadData()
    searchController.dismiss(animated: true, completion: nil)
  }
}

private extension PokedexCollectionController {
  func filterPokemon(withString searchString: String) {
    if searchString == "" {
      filteredPokedexEntries = pokedexEntries
      return
    }
    
    filteredPokedexEntries = pokedexEntries.filter({ (pokemon) -> Bool in
      return pokemon.id.formattedPokemonId.contains(searchString) || pokemon.name.contains(searchString.lowercased())
    })
    
    filteredPokedexEntries.sort { (p1, p2) -> Bool in
      return p1.id < p2.id
    }
  }
}
