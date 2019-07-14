//
//  MovieRepository.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

enum FlickTasticCategory: Int {
  case upComming, popular, topRated
}

class MovieRepository {

  static var app = MovieRepository()

  var delegate: MovieRepositoryDelegate!

  private let apiKey: String = "6424b629c8d2a9e4be6065dcf8b9c653"
  private let baseURL: String = "https://api.themoviedb.org/3/"

  func getMovies(forCategory category: FlickTasticCategory, andPage page: Int? = nil){

    switch category {
    case .upComming:
      requestUpCommingMovies(forPage: page)
    case .popular:
      requestPopularMovies(forPage: page)
    case .topRated:
      requestTopRated(forPage: page)
    }

  }

  private func requestPopularMovies(forPage page: Int?) {

  }

  private func requestUpCommingMovies(forPage page: Int?) {

  }

  private func requestTopRated(forPage page: Int?) {

  }

}


protocol MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int)
  func repository(_ repo: MovieRepository, didGetErrorMessage: String, forServiceType: FlickTasticCategory)
}
