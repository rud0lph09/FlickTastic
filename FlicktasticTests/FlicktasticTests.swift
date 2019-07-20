//
//  FlicktasticTests.swift
//  FlicktasticTests
//
//  Created by Rodolfo Castillo Vidrio on 7/13/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
@testable import Flicktastic

class FlicktasticTests: XCTestCase {

  var mockMovie = MovieModel(poster_path: "posterPath", adult: false, overview: "overview", release_date: "date", genre_ids: [1,2,3], id: 123, original_title: "originalTitle", original_lenguage: "leng", title: "title", backdrop_path: "backdrop", popularity: 123, vote_count: 123, video: true, vote_avarage: 123)

    override func setUp() {
    }

    func testExample() {
      let mockDictionary = try? mockMovie.asDictionary()
      XCTAssertNotNil(mockDictionary, "The dictionary was nil")
    }

}
