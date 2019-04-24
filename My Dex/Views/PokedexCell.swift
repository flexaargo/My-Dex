//
//  PokedexCell.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class PokedexCell: UICollectionViewCell {
  var pokemon: Pokemon! {
    didSet {
      
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .cardBackground
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PokedexCell: ReuseIdentifying {}
