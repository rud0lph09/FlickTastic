//
//  EncoderExtention.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/20/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
