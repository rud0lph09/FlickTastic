//
//  MovieRepository.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

enum FlickTasticCategory: String {
  case upComming = "upcoming"
  case popular = "popular"
  case topRated = "top_rated"
}

class MovieListRepository: Repository {

  var delegate: MovieListRepositoryDelegate!

  static var memoryCapacity = 100 * 1024 * 1024
  static var cache = URLCache(memoryCapacity: MovieListRepository.memoryCapacity, diskCapacity: MovieListRepository.memoryCapacity, diskPath: "shared")

  func getMovies(forCategory category: FlickTasticCategory, andPage page: Int? = nil){
    executeRequest(forCategory: category, andPage: page)
  }

  func moviePosterFullPath(forMovie movie: MovieModel, isThumbnail: Bool = false) -> String?  {
    guard let posterPath = movie.poster_path else { return nil }
    let size: FlicktasticImageSize = isThumbnail ? .thumbnail : .detail
    return imageBaseUrl + size.rawValue + posterPath
  }

  private func getURLForMovieRequest(_ category: FlickTasticCategory, andPage page: Int?) -> URL? {
    let category = category.rawValue
    let pathString = "\(baseURL)movie/\(category)?api_key=\(apiKey)&language=en-US&page=\(page != nil ? page!: 1)"
    return URL(string: pathString)
  }

  private func executeRequest(forCategory category: FlickTasticCategory, andPage page: Int?) {
    guard let url = getURLForMovieRequest(category, andPage: page) else { return }
    let config = URLSessionConfiguration.default
    config.urlCache = MovieListRepository.cache
    let session = URLSession(configuration: config)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    delegate.repository(self, willStartRequestForCategory: category)
    let task = session.dataTask(with: request) {
      (data, response, error) in

      guard error == nil else {
        self.delegate.repository(self,
                                 didGetError: MovieServiceErrorModel(statusMessage: error?.localizedDescription, statusCode: nil),
                                 forServiceType: category,
                                 inPage: page)
        return
      }
      guard let responseData = data else {
        self.delegate.repository(self,
                                 didGetError: MovieServiceErrorModel(statusMessage: "No data could be retrieved", statusCode: nil),
                                 forServiceType: category,
                                 inPage: nil)
        return
      }
      do {
        print()
        guard let responseModel = try? JSONDecoder().decode(MovieServiceResultModel.self, from: responseData) else {
          let errorModel = try? JSONDecoder().decode(MovieServiceErrorModel.self, from: responseData)
          self.delegate.repository(self, didGetError: errorModel ?? MovieServiceErrorModel(genericErrorWithCustomMessage: "Something wrong happened"), forServiceType: category, inPage: page)
          return
        }

        let movieList = responseModel.results
        let page = responseModel.page
        DispatchQueue.main.async {
          self.delegate.repository(self, didGetMovieList: movieList ?? [], forCategory: category, andPage: page)
        }

      }
    }
    task.resume()
  }

}


protocol MovieListRepositoryDelegate {
  func repository(_ repo: MovieListRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?)
  func repository(_ repo: MovieListRepository, didGetError: MovieServiceErrorModel, forServiceType: FlickTasticCategory, inPage page: Int?)
  func repository(_ repo: MovieListRepository, willStartRequestForCategory category: FlickTasticCategory)
}

