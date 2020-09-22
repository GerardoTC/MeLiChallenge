//
//  DescriptionInfoCell.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class DescriptionInfoCell: UITableViewCell {

    @IBOutlet weak var productDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - DescriptionInfoCellProtocol
extension DescriptionInfoCell: DescriptionInfoCellProtocol {
    func setup(with model: String?) {
        productDescription.text = model
    }
}
