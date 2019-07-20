//
//  MovieListTestController.swift
//  FlicktasticUITests
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieListTestController: MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, willStartRequestForCategory category: FlickTasticCategory) {
    
  }


  let repository = MovieRepository()

  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?) {

  }

  func repository(_ repo: MovieRepository, didGetError: MovieServiceErrorModel, forServiceType: FlickTasticCategory, inPage page: Int?) {

  }
}
