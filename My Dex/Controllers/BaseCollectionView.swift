//
//  BaseCollectionView.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionViewController {
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
