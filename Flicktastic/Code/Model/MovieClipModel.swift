//
//  MovieClipModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/20/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

class MovieClipModel: Codable {
  var id: String!
  var iso_639_1: String?
  var iso_3166_1: String?
  var key: String!
  var name: String?
  var site: String!
  var size: Int!
  var type: String!
}
