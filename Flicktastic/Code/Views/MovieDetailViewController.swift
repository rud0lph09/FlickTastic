//
//  MovieDetailViewController.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

  var viewModel: MovieDetailViewModel!

  @IBOutlet weak var movieDetailTable: UITableView!
  @IBOutlet weak var moviePosterView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!

  override func viewDidLoad() {
    movieDetailTable.delegate = self
    movieDetailTable.dataSource = self
    movieTitle.text = viewModel.movie.title
    moviePosterView.downloadImageFrom(Url: viewModel.getPosterPath() ?? "")
  }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
