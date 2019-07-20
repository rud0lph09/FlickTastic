//
//  MovieDetailCells.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/20/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieDetailDetailedCell: UITableViewCell {
  @IBOutlet weak var detailTextView: UITextView!

  func fill(withDetail detail: String) {
    detailTextView.text = detail
  }
}

class MovieDetailSimpleCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!

  func fill(withTitle title: String, value: String) {
    titleLabel.text = title
    valueLabel.text = value
  }
}
