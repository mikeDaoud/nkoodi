//
//  StoresViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class StoresViewController: BaseViewController {
    static let ID = "StoresViewController"
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var allStores = [Category]()
    var departmentsSearchResults = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStoresDummyData()
        setUpView()
    }
    
    func initStoresDummyData(){
        let store1 = Store(name: "El Beek", address: "Jaddah")
        let store2 = Store(name: "Bana", address: "Jaddah")
        let store3 = Store(name: "KFC", address: "Jaddah")
        let store4 = Store(name: "Mac", address: "Jaddah")
        let store5 = Store(name: "Hardies", address: "Jaddah")
        let stores = [store1, store2, store3, store4, store5]
        let category1 = Category(name: "Resturants", stores: stores)
        allStores.append(category1)
        
        let store6 = Store(name: "Zara", address: "Jaddah")
        let store7 = Store(name: "H&M", address: "Jaddah")
        let store8 = Store(name: "Paromoda", address: "Jaddah")
        let store9 = Store(name: "Teranova", address: "Jaddah")
        let store10 = Store(name: "LCWICII", address: "Jaddah")
        let stores2 = [store6, store7, store8, store9, store10]
        let category2 = Category(name: "Clothes", stores: stores2)
        allStores.append(category1)
        allStores.append(category2)
    }
    private func setUpView() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.darkGray
        searchController.searchBar.searchBarStyle = .minimal
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
//        tableView.register(UINib(nibName: ContactCell.ID, bundle: Bundle.main), forCellReuseIdentifier: ContactCell.ID)
    }
    
    fileprivate func getFilteredList(forSearchText searchText: String) -> [Category] {
        var filteredList =  [Category] ()
        for category in allStores {
            let stores = category.stores.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            if stores.count > 0 {
                var filteredCategory = category
                filteredCategory.stores = stores
                filteredList.append(filteredCategory)
            }
        }
        return filteredList
    }
    
    func search(forSearchText searchText: String) {
        if searchText.isEmpty {
            departmentsSearchResults = allStores
        } else {
            let filteredList = getFilteredList(forSearchText: searchText)
            departmentsSearchResults = filteredList
        }
    }
    
    static func create() -> StoresViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:
            StoresViewController.ID) as! StoresViewController
    }
}

extension StoresViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        search(forSearchText: searchController.searchBar.text!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return departmentsSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentsSearchResults[section].stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

