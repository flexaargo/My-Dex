//
//  PokeApi.swift
//  My Dex
//
//  Created by Alex Fargo on 4/23/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import Foundation

class PokeApi {
  static let shared: PokeApi = PokeApi() // Singleton
  
  let maxPokemonId: Int = 807;
  
  // Fetch a range of pokemon from some id to another id (inclusive)
  func fetchPokemon(fromId startId: Int = 1, toId endId: Int, completion: @escaping ([Pokemon]) -> ()) {
    // Create a temporary list to pass through completion
    var pokemonList = [Pokemon]()
    // Create a dispatch group to sync data fetches
    let dispatchGroup = DispatchGroup()
    for id in startId...endId {
      dispatchGroup.enter()
      fetchPokemon(withId: id) { (pokemon, err) in
        dispatchGroup.leave()
        if let _ = err {
          print("Error fetching pokemon with id: \(id)")
          return
        }
        pokemonList.append(pokemon!)
      }
    }
    // Once the dispatch group is completed, return to main queue and call completion
    dispatchGroup.notify(queue: .main) {
      completion(pokemonList)
    }
  }
  
  // Fetch a single pokemon with the given id
  func fetchPokemon(withId id: Int, completion: @escaping (Pokemon?, Error?) -> ()) {
    // If the id is greater than the databases most recent pokemon, return
    if id > maxPokemonId {
      print("Cannot access pokemon with id greater than \(maxPokemonId)")
      return
    }
    
    // Create a url string with the given id
    let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
    // Fetch the pokemon
    fetchJsonObject(urlString: urlString, completion: completion)
  }
  
  // Fetch a generic decodable object
  private func fetchJsonObject<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
    // Create a url from given url string
    guard let url = URL(string: urlString) else {
      print("Failed to create url from url string: \(urlString)")
      return
    }
    
    // Create a data task with created url
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      // Error fetching JSON
      if let err = err {
        print("Failed to fetch JSON\n", err)
        completion(nil, err)
        return
      }
      
      do {
        // Decode the json to a generic decodable object
        let obj = try JSONDecoder().decode(T.self, from: data!)
        completion(obj, nil)
      } catch {
        // There was an error decoding
        print("Failed to decode JSON\n", error)
        completion(nil, error)
      }
    }.resume()  // Complete the task
  }
}
