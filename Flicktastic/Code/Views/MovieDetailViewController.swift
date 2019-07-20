//
//  MovieDetailViewController.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailViewController: UIViewController {

  static var storyBoardID = "MovieDetailViewControllerID"

  var viewModel: MovieDetailViewModel!

  @IBOutlet weak var movieDetailTable: UITableView!
  @IBOutlet weak var moviePosterView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieBackgroundView: UIImageView!
  @IBOutlet weak var viewClipButton: UIButton!

  override func viewDidLoad() {
    movieDetailTable.delegate = self
    movieDetailTable.dataSource = self
    movieTitle.text = viewModel.movie.title
    moviePosterView.downloadImageFrom(Url: viewModel.getPosterPath() ?? "")
    movieBackgroundView.image = moviePosterView.image
    viewModel.clipsRepo.delegate = self
    viewModel.clipsRepo.getMovieClips(forMovie: viewModel.movie)
  }

  static func getController(withViewModel viewModel: MovieDetailViewModel) -> MovieDetailViewController? {
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(for: MovieDetailViewController.self))
    guard let controller = storyBoard.instantiateViewController(withIdentifier: MovieDetailViewController.storyBoardID) as? MovieDetailViewController else { return nil }
    controller.viewModel = viewModel
    return controller
  }

  @IBAction func viewClip() {

    guard let clipURl = viewModel.getYoutubeTrailerOrClip() else { return }
    if UIApplication.shared.canOpenURL(clipURl) {
      UIApplication.shared.openURL(clipURl)
    } else {
      let controller = SFSafariViewController(url: clipURl)
      DispatchQueue.main.async {
        self.present(controller, animated: true, completion: nil)
      }
    }
  }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1 + viewModel.getKeysArray().count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.row == 0 ? 158: 58
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var reusableID: String
    var cell: UITableViewCell?
    if indexPath.row == 0 {
      reusableID = MovieDetailCellTypeID.detailed.rawValue
      let detailedCell = tableView.dequeueReusableCell(withIdentifier: reusableID) as? MovieDetailDetailedCell
      detailedCell?.fill(withDetail: viewModel.movie.overview)
      cell = detailedCell
    } else if let movieDictionary = try? viewModel.movie.asDictionary() {
      let key = viewModel.getKeysArray()[indexPath.row - 1]
      let title = viewModel.getTitleForKey(key)
      let value = movieDictionary[key] as? String ?? "\(movieDictionary[key] ?? "--")"
      reusableID = MovieDetailCellTypeID.simple.rawValue
      let simpleCell = tableView.dequeueReusableCell(withIdentifier: reusableID) as? MovieDetailSimpleCell
      simpleCell?.fill(withTitle: title, value: value)
      cell = simpleCell
    }
    return cell ?? UITableViewCell()
  }
}

extension MovieDetailViewController: MovieClipsRepositoryDelegate {
  func repository(_ repo: MovieClipsRepository, didGetMovieClips movieClips: [MovieClipModel]) {
    viewModel.movieClips = movieClips
    guard viewModel.getYoutubeTrailerOrClip() != nil else { return }
    DispatchQueue.main.async {
      self.viewClipButton.isHidden = false
    }
  }

  func repository(_ repo: MovieClipsRepository, didGetError: MovieServiceErrorModel, forMovie: MovieModel) {
  }
}
