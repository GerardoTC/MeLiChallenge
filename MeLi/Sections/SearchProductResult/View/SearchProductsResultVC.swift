//
//  ViewController.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class SearchProductsResultVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateText: UILabel!
    var footerLoader: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    var presenter: SearchProductsResultPresenterProtocol?
    let cellRowHeight: CGFloat = 130
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.register(UINib(nibName: ViewConstants.NibNames.SearchProduct.productCell.rawValue, bundle: nil),
                           forCellReuseIdentifier: ViewConstants.CellIdentifiers.SearchProduct.productCell.rawValue)
        footerLoader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableFooterView = footerLoader
        presenter?.viewDidLoad()
    }
    
}

//MARK: - UITableViewDataSource
extension SearchProductsResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.SearchProduct.productCell.rawValue)
        presenter?.setupCell(cell as? ProductCellProtocol, at: indexPath.row)
        return cell ?? UITableViewCell()
    }
}

extension SearchProductsResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.itemSelected(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellRowHeight
    }
}

//MARK: - SearchProductsResultProtocol
extension SearchProductsResultVC: SearchProductsResultViewProtocol {
    func showEmptyState() {
        tableView.isHidden = true
        loader.isHidden = true
        emptyStateText.isHidden = false
    }
    
    func showLoading() {
        tableView.isHidden = true
        loader.isHidden = false
        loader.startAnimating()
        emptyStateText.isHidden = true
    }
    
    func hideLoading() {
        tableView.isHidden = false
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func showLoadingFooter() {
        footerLoader.startAnimating()
        tableView.tableFooterView?.isHidden = false        
    }
    
    func hideLoadingFooter() {
        footerLoader.stopAnimating()
        tableView.tableFooterView?.isHidden = true
    }
    
    func updateSearchBar(text: String) {
        searchBar.text = text
        emptyStateText.isHidden = true
    }
    
    func refreshView(scrollToTop: Bool) {
        tableView.reloadData()
        tableView.isHidden = false
        if tableView.numberOfRows(inSection: 0) != 0, scrollToTop {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchProductsResultVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        presenter?.searchBarselected()
        return false
    }
}
