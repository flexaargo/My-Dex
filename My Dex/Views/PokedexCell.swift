//
//  PokedexCell.swift
//  My Dex
//
//  Created by Alex Fargo on 4/24/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit
import SDWebImage

class PokedexCell: UICollectionViewCell {
  var pokemon: Pokemon! {
    didSet {
      print("\(pokemon.id.formattedPokemonId) - \(pokemon.name.capitalized)\t\t\(pokemon.types.count)")
      imageView.sd_setImage(with: URL(string: pokemon.imageURL))
      nameLabel.text = pokemon.name.capitalized
      idLabel.text = "#\(pokemon.id.formattedPokemonId)"
      if pokemon.types.count == 1 {
        type1Label.text = pokemon.types[0].name.capitalized
        type1Container.backgroundColor = pokemon.types[0].color
        type2Label.text = ""
        type2Container.backgroundColor = UIColor(white: 1, alpha: 0)
        type2Label.layer.shadowOpacity = 0
      } else {
        type1Label.text = pokemon.types[1].name.capitalized
        type1Container.backgroundColor = pokemon.types[1].color
        type2Label.text = pokemon.types[0].name.capitalized
        type2Container.backgroundColor = pokemon.types[0].color
        type2Label.layer.shadowOpacity = 1
      }
    }
  }
  
  let imageBackground: UIView = {
    let view = UIView()
    view.backgroundColor = .imageBackground
    view.layer.cornerRadius = 4
    return view
  }()
  
  let imageView: UIImageView = {
    let view = UIImageView()
    view.layer.cornerRadius = 4
    view.clipsToBounds = true
    return view
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .textBlack
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.textColor = .textLight
    label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  let type1Container: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 4
    return view
  }()
  
  let type1Label: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textAlignment = .center
    return label
  }()
  
  let type2Container: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 4
    return view
  }()
  
  let type2Label: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .cardBackground
    self.layer.cornerRadius = 8
    self.dropShadow(alpha: 0.25, x: 0, y: 2, blur: 4, spread: 0)
    type1Label.dropShadow(alpha: 0.5, x: 0, y: 0, blur: 4, spread: 0)
    type2Label.dropShadow(alpha: 0.5, x: 0, y: 0, blur: 4, spread: 0)
    self.layout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension PokedexCell {
  func layout() {
    let typeStackView = UIStackView(arrangedSubviews: [type1Container, type2Container])
    typeStackView.spacing = 6
    typeStackView.alignment = .center
    typeStackView.distribution = .fillEqually
    
    self.addSubview(imageBackground)
    imageBackground.addSubview(imageView)
    self.addSubview(nameLabel)
    self.addSubview(idLabel)
    self.addSubview(typeStackView)
    
    imageBackground.anchor(top: self.topAnchor, leading: self.leadingAnchor,
                           bottom: nameLabel.topAnchor, trailing: self.trailingAnchor,
                           padding: .init(top: 6, left: 6, bottom: 4, right: 6))
    imageBackground.constrainHeightToWidth()
    
    imageView.fillSuperview(padding: .init(top: 2, left: 2, bottom: 2, right: 2))
    
    nameLabel.anchor(top: imageBackground.bottomAnchor, leading: self.leadingAnchor,
                     bottom: idLabel.topAnchor, trailing: self.trailingAnchor,
                     padding: .init(top: 4, left: 6, bottom: 0, right: 6))
    
    idLabel.anchor(top: nameLabel.bottomAnchor, leading: self.leadingAnchor,
                   bottom: typeStackView.topAnchor, trailing: self.trailingAnchor,
                   padding: .init(top: 0, left: 6, bottom: 6, right: 6))
    
    typeStackView.anchor(top: idLabel.bottomAnchor, leading: self.leadingAnchor,
                         bottom: self.bottomAnchor, trailing: self.trailingAnchor,
                         padding: .init(top: 6, left: 6, bottom: 6, right: 6))
    
    type1Container.constrainHeight(constant: 18)
    type1Container.addSubview(type1Label)
    type1Label.fillSuperview()
    
    type2Container.constrainHeight(constant: 18)
    type2Container.addSubview(type2Label)
    type2Label.fillSuperview()
  }
}

extension PokedexCell: ReuseIdentifying {}
