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
  @IBOutlet weak var reloadButton: UIButton!
  @IBOutlet weak var reloadButtonHeightConstraint: NSLayoutConstraint!
  let viewModel = MovieListViewModel()
  var serviceIsFetching = false

  override func viewDidLoad() {
    super.viewDidLoad()
    movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    movieCollectionView.delegate = self
    movieCollectionView.dataSource = self
    viewModel.setRepoDelegate(self)
    viewModel.loadMovies(withCategory: viewModel.currentCategory)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
  }

  @IBAction func reload(){
    if viewModel.getMovieListCount() == 0 {
      viewModel.loadMovies(withCategory: viewModel.currentCategory)
    }
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

  func animateChanges() {
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }

  func hideReloadButton(){
    DispatchQueue.main.async {
      self.reloadButtonHeightConstraint.constant = self.viewModel.offlineButtonHiddenHeight
      self.animateChanges()
    }
    self.reloadButton.setTitle("", for: .normal)
  }

}

extension MovieListViewController: MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?) {
    serviceIsFetching = false
    let minimumPageValue = 1
    viewModel.checkForPreviusError(inPage: page ?? 1) { (shouldHideReloadButton) in
      if shouldHideReloadButton {
        self.hideReloadButton()
      }
    }
    viewModel.movieListShouldUpdate(withMovieCollection: movieList, commingFromPage: page ?? minimumPageValue, withCollectionView: movieCollectionView)
  }

  func repository(_ repo: MovieRepository, didGetError: MovieServiceErrorModel, forServiceType: FlickTasticCategory, inPage page: Int?) {
    serviceIsFetching = false
    DispatchQueue.main.async {
      if let statusMessage = didGetError.statusMessage , statusMessage == CommonErrorMessages.connection {
        self.reloadButtonHeightConstraint.constant = self.viewModel.offlineButtonHeight
        self.animateChanges()
        self.viewModel.registerErrorOnPage(page ?? 1)
        if self.viewModel.getMovieListCount() == 0 {
          self.reloadButton.setTitle(self.viewModel.tapToReloadString, for: .normal)
        } else {
          self.reloadButton.setTitle(self.viewModel.offlineString, for: .normal)
        }
      } else {
        let code = didGetError.statusCode != nil ? "\(didGetError.statusCode!)" : ""
        let message = didGetError.statusMessage ?? self.viewModel.unknownErrorString
        let alert = UIAlertController(title: "Error: " + code,
                                      message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
      }
    }
  }

  func repository(_ repo: MovieRepository, willStartRequestForCategory category: FlickTasticCategory) {
    serviceIsFetching = true
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
    if !serviceIsFetching {
      let indexOffset = 1
      let movieCountIndex = indexOffset + indexPath.row
      let currentPage = viewModel.getCurrentPage()
      let maxNumberOfMoviesPerPage = 20

      if ( movieCountIndex / maxNumberOfMoviesPerPage ) == currentPage {
        viewModel.loadMovies(withCategory: viewModel.currentCategory, andPage: viewModel.getNextPage())

      }
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedMovie = viewModel.movieList[indexPath.row]
    let detailViewModel = MovieDetailViewModel(withMovieModel: selectedMovie)
    guard let controller = MovieDetailViewController.getController(withViewModel: detailViewModel) else { return }
    self.navigationController?.pushViewController(controller, animated: true)
  }

}

