//
//  MovieDetailViewModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieDetailViewModel {

  let simpleDetailsKeysAndValues = ["release_date": "Release date", "adult": "Suitable for minors", "original_title": "Original title", "original_lenguage": "Original lenguage", "popularity": "Popularity", "vote_count": "Vote count", "vote_avarage": "Vote avarage"]

  var repo = MovieRepository()

  var movie: MovieModel!

  init(withMovieModel movie: MovieModel) {
    self.movie = movie
  }

  func getPosterPath() -> String? {
    return repo.moviePosterFullPath(forMovie: movie, isThumbnail: false)
  }
  
}
