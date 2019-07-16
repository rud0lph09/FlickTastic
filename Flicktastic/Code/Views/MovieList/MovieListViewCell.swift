//
//  MovieListViewCell.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieListViewCell: UICollectionViewCell {
  @IBOutlet weak var posterView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!

  static var reusableID = "movieListViewCell"
  
  func fill(withPosterPath posterPath: String, title: String) {
    self.titleLabel.text = title
    self.posterView.downloadImageFrom(Url: posterPath)
  }
}
