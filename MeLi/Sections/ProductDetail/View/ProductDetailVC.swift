//
//  ItemDetailVC.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    var presenter: ProductDetailPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ViewConstants.NibNames.ProductDetail.imagesCell.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: ViewConstants.CellIdentifiers.ProductDetail.imagesCell.rawValue)
        tableView.register(UINib(nibName: ViewConstants.NibNames.ProductDetail.productInfoCell.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: ViewConstants.CellIdentifiers.ProductDetail.productInfoCell.rawValue)
        tableView.register(UINib(nibName: ViewConstants.NibNames.ProductDetail.descriptionInfoCell.rawValue,
                                 bundle: nil),
                           forCellReuseIdentifier: ViewConstants.CellIdentifiers.ProductDetail.descriptionInfoCell.rawValue)
        presenter?.viewDidLoad()
    }
    

    @IBAction
    func backButtonPressed() {
        presenter?.backButtonPressed()
    }
}

//MARK: - ProductDetailViewProtocol
extension ProductDetailVC: ProductDetailViewProtocol {
    func refreshView() {
        tableView.reloadData()
    }
}
//MARK: - UITableViewDataSource
extension ProductDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.ProductDetail.imagesCell.rawValue) as? ImagesCell
            presenter?.setupCell(cell as? ImagesCellProtocol)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.ProductDetail.productInfoCell.rawValue)
            presenter?.setupCell(cell as? ProductInfoCellProtocol)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.ProductDetail.descriptionInfoCell.rawValue)
            presenter?.setupCell(cell as? DescriptionInfoCellProtocol)
        default:
            break
        }
        
        return cell ?? UITableViewCell()
    }
}

extension ProductDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 240: UITableView.automaticDimension
    }
}
