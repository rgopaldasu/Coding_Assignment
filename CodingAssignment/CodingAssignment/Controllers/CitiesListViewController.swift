//
//  CitiesListViewController.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    let tblView : UITableView = {
        let tableview = UITableView()
        return tableview
    } ()
    
    let searchbar: UISearchBar = {
        let searchbar = UISearchBar ()
        searchbar.showsCancelButton = true
        searchbar.sizeToFit()
        return searchbar
    } ()
    
    var citiesViewModel: CitiesListViewModel!
    private var dataSource: TableViewDataSourceAndDelegate<CityTableViewCell, CityModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewSetup()
        self.initializingCitiesListViewModel()
        self.navigationItem.titleView = searchbar
        self.searchbar.delegate = self
    }
    
    // Added constraints to tableview and registerd Tableviewcell
    func tableViewSetup() {
        self.view.addSubview(tblView)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tblView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tblView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tblView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tblView.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // Initialized CitiesListViewModel and registering call back.
    func initializingCitiesListViewModel () {
        citiesViewModel = CitiesListViewModel()
        citiesViewModel.bindCityViewModelToController = {
            self.updateDataSource()
        }
        citiesViewModel.readJSONFromFile()
    }
    
    // Adding DataSource and Delegate methods to tableview.
    func updateDataSource () {
        // Configure TableViewCell datasource and delegates.
        self.dataSource = TableViewDataSourceAndDelegate(cellIdentifier: "cell", items:self.citiesViewModel.citiesList, configureCell: { (cell, cityObj) in
            cell.textLabel?.text = "\(cityObj.name ?? ""), \(cityObj.country ?? "")"
            cell.detailTextLabel?.text = "\(cityObj.coord?.lat ?? 0.0), \(cityObj.coord?.lon ?? 0.0)"
        })
        
        // Callback to tableview row selected.
        self.dataSource.rowSelected = {(cityObj) in
            let mapVC = MapViewController ()
            mapVC.citiyModel = cityObj
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
        
        // Assign datasource,delegate and reloading tableview.
        DispatchQueue.main.async {
            self.tblView.dataSource = self.dataSource
            self.tblView.delegate = self.dataSource
            self.tblView.reloadData()
        }
    }
}

// MARK: Searchbar delegate methods.
extension CitiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citiesViewModel.reloadWithFilter(searchString: searchbar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        citiesViewModel.reloadWithFilter(searchString: "")
        self.searchbar.resignFirstResponder()
    }
}
