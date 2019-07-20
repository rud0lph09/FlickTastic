//
//  MovieClipsServiceResultModel.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/20/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieClipsServiceResultModel: Codable {
  var id: Int!
  var results: [MovieClipModel] = []
}
