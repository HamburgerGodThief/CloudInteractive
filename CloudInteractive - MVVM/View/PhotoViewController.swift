//
//  PhotoViewController.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoViewModel: PhotoViewModel = PhotoViewModel()
    
    let itemSpace: CGFloat = 1
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoViewModel.readAPI(completion: {
            DispatchQueue.main.async { [weak self] in
                self?.loadingIndicatorView.stopAnimating()
                self?.loadingIndicatorView.isHidden = true
                self?.collectionView.reloadData()
            }
        })
    }
    
}

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.idLbl.text = "\(photoViewModel.photos[indexPath.item].id)"
        cell.titleLbl.text = photoViewModel.photos[indexPath.item].title
        photoViewModel.urlToImage(index: indexPath.item, completion: { (image) in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
                cell.loadingIndicatorView.stopAnimating()
                cell.loadingIndicatorView.isHidden = true
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(floor((collectionView.frame.size.width - itemSpace * 3) / 4 ))
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return itemSpace
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat {
        return itemSpace
    }
}
