//
//  ProductCell.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit
import Kingfisher
class ProductCell: UITableViewCell {

    @IBOutlet weak var backgroundViewContainer: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var freeShipping: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//MARK: - ProductCellProtocol
extension ProductCell: ProductCellProtocol {
    func setup(with model: ProductResult) {
        let url = URL(string: model.imageUrl)
        productImageView.contentMode = .scaleAspectFit
        productImageView.kf.setImage(with: url,
                                     placeholder: UIImage(named: "emptyImage"),
                                     options: [.transition(.fade(0.5))])
        titleText.text = model.title
        priceText.text = model.value.toCurrencyFormat()
        freeShipping.isHidden = !model.freeShipping
        
    }
}
