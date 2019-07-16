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
  private var currentPage = 0

  func getMovie(forIndex index: Int) -> MovieModel? {
    return index < movieList.count ? movieList[index] : nil
  }

  func getNextPage() -> Int {
    return getCurrentPage() + 1
  }

  func getCurrentPage() -> Int {
    let maxNumberPerPage = 20
    self.currentPage = ( movieList.count / maxNumberPerPage )
    return currentPage
  }

  func getMovieListCount() -> Int {
    return self.movieList.count
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




