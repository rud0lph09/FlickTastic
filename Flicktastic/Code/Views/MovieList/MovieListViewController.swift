//
//  MovieListViewController.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
  @IBOutlet weak var movieCollectionView: UICollectionView!

  let repository = MovieRepository()
  let viewModel = MovieListViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    movieCollectionView.delegate = self
    movieCollectionView.dataSource = self
    repository.delegate = self
    repository.getMovies(forCategory: .popular, andPage: viewModel.getCurrentPage())
  }
}

extension MovieListViewController: MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?) {
    let minimumPageValue = 1
    viewModel.movieListShouldUpdate(withMovieCollection: movieList, commingFromPage: page ?? minimumPageValue)
    movieCollectionView.reloadData()
  }

  func repository(_ repo: MovieRepository, didGetError: MovieServiceErrorModel, forServiceType: FlickTasticCategory, inPage page: Int?) {
    let code = didGetError.statusCode != nil ? "\(didGetError.statusCode!)" : ""
    let message = didGetError.statusMessage ?? "Something wrong happened, could load movies :C"
    let alert = UIAlertController(title: "Error: " + code,
                                  message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Okey", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }


}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getMovieListCount()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListViewCell.reusableID, for: indexPath) as? MovieListViewCell, let movie = viewModel.getMovie(forIndex: indexPath.row) else { return UICollectionViewCell() }
    let posterPath = repository.moviePosterFullPath(forMovie: movie, isThumbnail: true)
    cell.fill(withPosterPath: posterPath ?? "", title: movie.title)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfMoviesPerRow: CGFloat = 3.0
    let width = self.view.frame.width / numberOfMoviesPerRow
    let heightProportion: CGFloat = 1.48
    let height = width * heightProportion
    return CGSize(width: width, height: height)
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  public func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

}

