//
//  GroupsSearch.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

class GroupsSearch: UITableViewController {
    
    @IBOutlet var allGroupsSearch: UISearchBar!
    
    private var timer = Timer()
    private let networkService = NetworkService<Group>()
    private var searchQuery = String()
    
    var allGroupsFiltered = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(
            nibName: "GroupCell",
            bundle: nil),
            forCellReuseIdentifier: "groupCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroupsFiltered.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        
        let availableGroup = allGroupsFiltered[indexPath.row]

        cell.configure(
            name: availableGroup.name,
            url: availableGroup.avatar)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true) }
        performSegue(
            withIdentifier: "addGroup",
            sender: nil)
    }
}

extension GroupsSearch: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {

        searchQuery = searchText
        allGroupsFiltered.removeAll()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in networkServiceFunction() })
    }
    
    func  networkServiceFunction() {
        
        networkService.fetch(type: .groupSearch, q: searchQuery) { [weak self] result in
            
                switch result {
                case .success(let allGroups):
                    allGroups.forEach() { item in
                        self?.allGroupsFiltered.append(
                            Group(id: item.id,
                                  name: item.name,
                                  avatar: item.avatar))
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
