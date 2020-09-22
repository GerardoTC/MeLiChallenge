//
//  ImagesCell.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit
import Kingfisher

class ImagesCell: UITableViewCell {
    
    @IBOutlet weak var totalPhotos: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [URL] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc
    private func showImageDetail(imageView: UIImageView, url: URL?) {
        let mainView = collectionView.findViewController()?.view ?? UIView()
        let imageDetailFrame = CGRect(x: 0,
                                      y: 0,
                                      width: mainView.frame.width,
                                      height: mainView.frame.height)
        let imageDetail = ImageDetailView(frame: imageDetailFrame)
        imageDetail.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(imageDetail)
        NSLayoutConstraint.activate([
            imageDetail.topAnchor.constraint(equalTo: mainView.topAnchor),
            imageDetail.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            imageDetail.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            imageDetail.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        
        imageDetail.showDetail(imageView, url: url, viewContainer: self.collectionView.superview ?? UIView())
    }
}

//MARK: - ImagesCellProtocol
extension ImagesCell: ImagesCellProtocol {
    func setup(with model: [URL]) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
        images = model
        collectionView.reloadData()
        if images.count > 1 {
            totalPhotos.isHidden = false
            totalPhotos.text = "\(images.count) Fotos"
            totalPhotos.layer.cornerRadius = 10
        } else {
            totalPhotos.isHidden = true
        }
        
    }
}

//MARK: - CollectionView DataSource
extension ImagesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as? ImageCollectionCell
        let image = images[indexPath.row]
        
        cell?.imageView.kf.setImage(with: image,
                                    placeholder: UIImage(named: "emptyImage"),
                                    options: [.transition(.fade(0.5))])
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - CollectionView Delegate
extension ImagesCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as? ImageCollectionCell
        guard let imageView = cell?.imageView else {
            return
        }
        
        showImageDetail(imageView: imageView, url: images[indexPath.row])
    }
}
