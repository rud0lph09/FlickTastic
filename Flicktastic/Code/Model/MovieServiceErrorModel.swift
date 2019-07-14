//
//  MovieServiceErrorModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct MovieServiceErrorModel: Codable {
  var statusMessage: String!
  var statusCode: Int!
}
