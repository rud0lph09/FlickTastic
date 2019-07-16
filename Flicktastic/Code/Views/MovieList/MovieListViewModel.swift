//
//  MovieListViewModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

class MovieListViewModel {
  var movieList: [MovieModel] = []
  var currentCategory: FlickTasticCategory = .popular
  private var currentPage = 0

  func getMovie(forIndex index: Int) -> MovieModel? {
    return index < movieList.count ? movieList[index] : nil
  }

  func getCurrentPage() -> Int {
    self.currentPage = ( movieList.count / 20 ) + 1
    return currentPage
  }

  func getMovieListCount() -> Int {
    return self.movieList.count
  }
}




