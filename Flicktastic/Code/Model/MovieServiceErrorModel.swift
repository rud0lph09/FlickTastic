//
//  MovieServiceErrorModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/14/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct CommonErrorMessages {
  static var connection = "The Internet connection appears to be offline."
}

struct MovieServiceErrorModel: Codable {
  var statusMessage: String?
  var statusCode: Int?

  init(genericErrorWithCustomMessage message: String) {
    self.statusCode = nil
    self.statusMessage = message
  }

  init(statusMessage: String!, statusCode: Int!){
    self.statusMessage = statusMessage
    self.statusCode = statusCode
  }
}
