//
//  MovieModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
  var poster_path: String?
  var adult: Bool!
  var overview: String!
  var release_date: String!
  var genre_ids: [Int]!
  var id: Int!
  var original_title: String!
  var original_lenguage: String!
  var title: String!
  var backdrop_path: String?
  var popularity: Double!
  var vote_count: Int!
  var video: Bool!
  var vote_avarage: Double!
}
