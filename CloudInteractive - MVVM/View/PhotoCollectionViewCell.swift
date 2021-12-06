//
//  PhotoCollectionViewCell.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView! {
        didSet {
            loadingIndicatorView.startAnimating()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
