//
//  MovieDetailViewModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

enum MovieDetailCellTypeID: String {
  case detailed = "detailCell", simple = "simpleCell"
}

class MovieDetailViewModel {

  private let simpleDetailsKeysAndValues = ["release_date": "Release date", "original_title": "Original title", "original_lenguage": "Original lenguage", "popularity": "Popularity", "vote_count": "Vote count", "vote_avarage": "Vote avarage"]

  var unknownErrorString = "Something wrong happened, could load movies :C"

  var clipsRepo = MovieClipsRepository()
  var repo = MovieListRepository()

  var movieClips: [MovieClipModel] = []
  var movie: MovieModel!

  func getYoutubeTrailerOrClip() -> URL? {
    for clip in movieClips {
      if let site = clip.site, site == "YouTube" {
        let youtubePath = clipsRepo.youtubeBaseUrl + clip.key
        return URL(string: youtubePath)
      }
    }
    return nil
  }

  init(withMovieModel movie: MovieModel) {
    self.movie = movie
  }

  func getKeysArray() -> [String] {
    return Array(simpleDetailsKeysAndValues.keys)
  }

  func getTitleForKey(_ key: String) -> String {
    return simpleDetailsKeysAndValues[key] ?? ""
  }

  func getPosterPath() -> String? {
    return repo.moviePosterFullPath(forMovie: movie, isThumbnail: false)
  }
  
}
