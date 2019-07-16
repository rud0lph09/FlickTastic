//
//  UIImage.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

extension UIImageView {
  func downloadImageFrom(Url urlString:String) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, urlResponse, responseError) in
      guard let imageData = data, responseError == nil else  { return }

      DispatchQueue.main.async {
        self.image = UIImage(data: imageData)
      }
    }.resume()
  }
}
