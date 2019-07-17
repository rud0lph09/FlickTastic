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

  let viewModel = MovieListViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    movieCollectionView.delegate = self
    movieCollectionView.dataSource = self
    viewModel.setRepoDelegate(self)
    viewModel.loadMovies(withCategory: .popular)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
  }

  @IBAction func toggleChangeOfCategory(_ sender: Any) {
    guard let toggle = sender as? UISegmentedControl else { return }
    var selectedCategory: FlickTasticCategory
    switch toggle.selectedSegmentIndex {
    case 0:
      selectedCategory = .popular
    case 1:
      selectedCategory = .topRated
    case 2:
      selectedCategory = .upComming
    default:
      return
    }
    viewModel.loadMovies(withCategory: selectedCategory, inCollectionView: self.movieCollectionView)
  }

}

extension MovieListViewController: MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?) {
    let minimumPageValue = 1
    viewModel.movieListShouldUpdate(withMovieCollection: movieList, commingFromPage: page ?? minimumPageValue, withCollectionView: movieCollectionView)
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

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getMovieListCount()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListViewCell.reusableID, for: indexPath) as? MovieListViewCell, let movie = viewModel.getMovie(forIndex: indexPath.item) else { return UICollectionViewCell() }
    let posterPath = viewModel.getMoviePosterPath(atIndex: indexPath.item)
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

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let indexOffset = 1
    let movieCountIndex = indexOffset + indexPath.row
    let currentPage = viewModel.getCurrentPage()
    let maxNumberOfMoviesPerPage = 20

    if ( movieCountIndex / maxNumberOfMoviesPerPage ) == currentPage {
      viewModel.loadMovies(withCategory: viewModel.currentCategory, andPage: viewModel.getNextPage())
      
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0)
  }

}

