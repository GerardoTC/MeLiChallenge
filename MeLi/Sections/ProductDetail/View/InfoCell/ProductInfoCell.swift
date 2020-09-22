//
//  ProductInfoCell.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class ProductInfoCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var freeShipping: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//MARK: - ProductCellProtocol
extension ProductInfoCell: ProductInfoCellProtocol {
    func setup(with model: ProductResult?) {
        title.text = model?.title
        price.text = model?.value.toCurrencyFormat()
        if model?.freeShipping ?? false {
            freeShipping.isHidden = false
        } else {
            freeShipping.isHidden = true
        }
    }
}
