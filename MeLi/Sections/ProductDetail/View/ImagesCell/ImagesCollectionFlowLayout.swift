//
//  ImagesCollectionFlowLayout.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit


class ImagesCollectionFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        itemSize = CGSize(width: collectionView.frame.width,
                          height: collectionView.frame.height)
    }
}
