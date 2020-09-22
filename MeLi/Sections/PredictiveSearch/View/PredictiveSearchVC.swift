//
//  PredictiveSearchVC.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class PredictiveSearchVC: UIViewController {
    var presenter: PredictiveSearchPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.viewDidLoad()
        
    }
    
    @IBAction
    func cancelButtonPressed() {
        presenter?.cancelButtonPressed()
    }
}

//MARK: -UITableViewDataSource
extension PredictiveSearchVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.PredictiveSearch.predictiveLocalSearchCell.rawValue),
            indexPath.section == 0 {
            tableCell = cell
            cell.textLabel?.text = presenter?.suggestion(at: indexPath.row, section: indexPath.section)
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.PredictiveSearch.predictiveSearchCell.rawValue),
            indexPath.section == 1 {
            tableCell = cell
            cell.textLabel?.text = presenter?.suggestion(at: indexPath.row, section: indexPath.section)
        }
        return tableCell
    }
}

//MARK: - UITableViewDelegate
extension PredictiveSearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectSuggestion(index: indexPath.row, section: indexPath.section)        
    }
}

//MARK: - PredictiveSearchViewProtocol
extension PredictiveSearchVC: PredictiveSearchViewProtocol {
    func focusOnSearchText() {
        searchBar.becomeFirstResponder()
    }
    
    func refreshView() {
        tableView.reloadData()
    }
}

//MARK: -SearchBarDelegate
extension PredictiveSearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.textDidChange(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchButtonClicked(text: searchBar.text)
    }
}
