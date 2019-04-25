//
//  PokedexNavigationController.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class PokedexNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.tintColor = .white
    navigationBar.barTintColor = .primaryRed
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false
    navigationBar.isOpaque = true
    navigationBar.prefersLargeTitles = true
  }
}
