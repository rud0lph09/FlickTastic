//
//  MovieListViewModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieListViewModel {
  var movieList: [MovieModel] = []
  var currentCategory: FlickTasticCategory = .popular
  private var repo = MovieListRepository()
  private var currentPage = 0
  private var lastPageWithError: Int? = nil

  var tapToReloadString = "You appear to be offline. Tap here to reload."
  var offlineString = "You are offline."
  var offlineButtonHeight: CGFloat = 50
  var offlineButtonHiddenHeight: CGFloat = 0

  var unknownErrorString = "Something wrong happened, could load movies :C"

  func getMovie(forIndex index: Int) -> MovieModel? {
    return index < movieList.count ? movieList[index] : nil
  }

  func setRepoDelegate(_ delegate: MovieListRepositoryDelegate) {
    self.repo.delegate = delegate
  }

  func getNextPage() -> Int {
    return getCurrentPage() + 1
  }

  func registerErrorOnPage(_ page: Int) {
    self.lastPageWithError = page
  }

  func checkForPreviusError(inPage page: Int, completion: (Bool)->()) {
    completion(page == lastPageWithError)
  }

  func getMoviePosterPath(atIndex index: Int) -> String? {
    return self.repo.moviePosterFullPath(forMovie: movieList[index], isThumbnail: true)
  }

  func getCurrentPage() -> Int {
    let maxNumberPerPage = 20
    self.currentPage = ( movieList.count / maxNumberPerPage )
    return currentPage
  }

  func getMovieListCount() -> Int {
    return self.movieList.count
  }

  func loadMovies(withCategory category: FlickTasticCategory, inCollectionView collectionView: UICollectionView? = nil, andPage page: Int? = nil) {
    self.shouldChangeCategory(selectedCategory: category, inCollectionView: collectionView)
    repo.getMovies(forCategory: category, andPage: page)
  }

  private func shouldChangeCategory(selectedCategory: FlickTasticCategory, inCollectionView collectionView: UICollectionView?) {
    guard let collectionViewToUpdate = collectionView else { return }
    if self.currentCategory.rawValue != selectedCategory.rawValue {
      self.lastPageWithError = nil
      self.currentCategory = selectedCategory
      self.movieList = []
      collectionViewToUpdate.reloadData()
    }
  }

  func movieListShouldUpdate(withMovieCollection movieCollection: [MovieModel], commingFromPage page: Int, withCollectionView collectionView: UICollectionView){
    if page > getCurrentPage() || movieList.count <= 0 {
      addNewMovies(movieCollection, toCollectionView: collectionView)
    }
  }

  private func addNewMovies(_ movieCollection: [MovieModel], toCollectionView collectionView: UICollectionView) {
    let indexOffset = 1
    for movie in movieCollection {
      movieList.append(movie)
      collectionView.insertItems(at: [IndexPath(item: movieList.count - indexOffset, section: 0)])
    }
  }


}




