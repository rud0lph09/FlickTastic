//
//  MovieServiceResultModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct Dates: Codable {
  var maximum: String!
  var minimum: String!
}

struct MovieServiceResultModel: Codable {
  var page: Int!
  var results: [MovieModel]!
  var dates: Dates?
  var total_pages: Int!
  var total_results: Int!
}
