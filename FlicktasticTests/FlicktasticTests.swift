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

  var mockController = MovieListTestController()

    override func setUp() {
      mockController.repository.delegate = mockController
    }

    func testExample() {
        mockController.repository.getMovies(forCategory: .popular)
    }

}
