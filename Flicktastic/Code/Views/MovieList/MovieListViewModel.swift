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
    let maxNumberPerPage = 20
    let indexOffset = 1
    self.currentPage = ( movieList.count / maxNumberPerPage ) + indexOffset
    return currentPage
  }

  func getMovieListCount() -> Int {
    return self.movieList.count
  }

  func movieListShouldUpdate(withMovieCollection movieCollection: [MovieModel], commingFromPage page: Int){
    if page > getCurrentPage() && movieList.count <= 0 {
      self.movieList += movieCollection
    } else if page <= getCurrentPage() {
      updatePage(page, withMovieCollection: movieCollection)
    }
  }

  private func updatePage(_ page: Int, withMovieCollection movieCollection: [MovieModel]) {
    var pages: [[MovieModel]] = []
    let indexOffset = 1
    for pageIndex in 0..<getCurrentPage() {
      let selectedPageMovieCollection = getMovieCollection(forPage: page)
      if pageIndex + indexOffset == page {
        pages.append(movieCollection)
      } else {
        pages.append(selectedPageMovieCollection)
      }
    }
    movieList = []
    for eachPage in pages {
      for movie in eachPage {
        movieList.append(movie)
      }
    }
  }

  private func getMovieCollection(forPage selectedPage: Int) -> [MovieModel] {
    var page: [MovieModel] = []
    let maxNumberPerPage = 20
    let indexOffset = 1
    for movieIndex in 0..<movieList.count {
      if (movieIndex + indexOffset / maxNumberPerPage) + indexOffset == selectedPage {
        page.append(movieList[movieIndex])
      }
    }
    return page
  }
}




