//
//  File.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/20/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

class MovieClipsRepository: Repository {

  var delegate: MovieClipsRepositoryDelegate!

  func getMovieClips(forMovie movie: MovieModel){
    self.executeRequest(forMovie: movie)
  }

  private func getURLForMovieRequest(_ movie: MovieModel) -> URL? {
    guard let id = movie.id else { return nil }
    let pathString = "\(baseURL)movie/\(id)/videos?api_key=\(apiKey)&language=en-US"
    return URL(string: pathString)
  }

  private func executeRequest(forMovie movie: MovieModel) {
    guard let url = getURLForMovieRequest(movie) else { return }
    let config = URLSessionConfiguration.default
    config.urlCache = MovieListRepository.cache
    let session = URLSession(configuration: config)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let task = session.dataTask(with: request) {
      (data, response, error) in

      guard error == nil else {
        self.delegate.repository(self,
                                 didGetError: MovieServiceErrorModel(statusMessage: error?.localizedDescription, statusCode: nil),
                                 forMovie: movie)
        return
      }
      guard let responseData = data else {
        self.delegate.repository(self,
                                 didGetError: MovieServiceErrorModel(statusMessage: "No data could be retrieved", statusCode: nil), forMovie: movie)
        return
      }
      do {
        print()
        guard let responseModel = try? JSONDecoder().decode(MovieClipsServiceResultModel.self, from: responseData) else {
          let errorModel = try? JSONDecoder().decode(MovieServiceErrorModel.self, from: responseData)
          self.delegate.repository(self, didGetError: errorModel ?? MovieServiceErrorModel(genericErrorWithCustomMessage: "Something wrong happened"), forMovie: movie)
          return
        }
        let clips = responseModel.results
        self.delegate.repository(self, didGetMovieClips: clips)
      }
    }
    task.resume()
  }
}


protocol MovieClipsRepositoryDelegate {
  func repository(_ repo: MovieClipsRepository, didGetMovieClips movieClips: [MovieClipModel])
  func repository(_ repo: MovieClipsRepository, didGetError: MovieServiceErrorModel, forMovie: MovieModel)
}

