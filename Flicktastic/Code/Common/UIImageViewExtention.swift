//
//  UIImage.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

enum FlicktasticImageSize: String {
  case thumbnail = "w200"
  case detail = "w500"
}

extension UIImageView {
  func downloadImageFrom(Url urlString:String) {
    self.alpha = 0
    guard let url = URL(string: urlString) else { return }
    let config = URLSessionConfiguration.default
    config.urlCache = MovieRepository.cache
    let session = URLSession(configuration: config)
    session.dataTask(with: url) { (data, urlResponse, responseError) in
      guard let imageData = data, responseError == nil else  { return }
      DispatchQueue.main.async {
        UIView.animate(withDuration: 0.4, animations: {
          self.alpha = 1
          self.image = UIImage(data: imageData)
        })
      }
    }.resume()
  }
}
