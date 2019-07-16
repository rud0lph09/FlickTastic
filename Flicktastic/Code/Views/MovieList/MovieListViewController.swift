//
//  MovieListViewController.swift
//  Flicktastic
//
//  Created by Rodolfo Castillo Vidrio on 7/15/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
  @IBOutlet weak var movieCollectionView: UICollectionView!

  let repository = MovieRepository()
  let viewModel = MovieListViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    movieCollectionView.delegate = self
    repository.delegate = self
    repository.getMovies(forCategory: .popular, andPage: viewModel.getCurrentPage())
  }
}

extension MovieListViewController: MovieRepositoryDelegate {
  func repository(_ repo: MovieRepository, didGetMovieList movieList: [MovieModel], forCategory category: FlickTasticCategory, andPage page: Int?) {
    print(movieList)
  }

  func repository(_ repo: MovieRepository, didGetError: MovieServiceErrorModel, forServiceType: FlickTasticCategory, inPage page: Int?) {
    let code = didGetError.statusCode != nil ? "\(didGetError.statusCode!)" : ""
    let message = didGetError.statusMessage ?? "Something wrong happened, could load movies :C"
    let alert = UIAlertController(title: "Error: " + code,
                                  message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Okey", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }


}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getMovieListCount()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = self.view.frame.width
    let heightProportion: CGFloat = 1.48
    let height = width * heightProportion
    return CGSize(width: width, height: height)
  }

}
