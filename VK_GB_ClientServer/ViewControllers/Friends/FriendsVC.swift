//
//  FriendsVC.swift
//  VK_GB_ClientServer
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit
import RealmSwift

final class FriendsVC: UITableViewController,
                       UIGestureRecognizerDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    private var friendsDictionary = [String: [UserRealm]]()
    private var friendsSectionTitles = [String]()
    private var friendsFilteredDictionary = [String: [UserRealm]]()
    private let networkService = NetworkService<User>()
    private var friends: Results<UserRealm>? = try? RealmService.load(typeOf: UserRealm.self)
    private var friendsToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.sectionHeaderTopPadding = 0
        
        tableView.register(UINib(
            nibName: "FriendCell",
            bundle: nil),
            forCellReuseIdentifier: "friendCell")
        
        networkServiceFunction()
        sortFriends()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        friendsToken = friends?.observe { [weak self] friendsChanges in
            guard let self = self else { return }
            switch friendsChanges {
            case .initial, .update:
                self.sortFriends()
            case .error(let error):
                print(error)
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        friendsToken?.invalidate()
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        friendsSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsFilteredDictionary[friendsSectionTitles[section]]!.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSectionTitles
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplayHeaderView view: UIView,
                            forSection section: Int) {
        
        let header = view as? UITableViewHeaderFooterView
        header?.tintColor = UIColor.gray.withAlphaComponent(0.05)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell else { return UITableViewCell() }
        let letterKey = friendsSectionTitles[indexPath.section]
           if let friendsOnLetterKey = friendsFilteredDictionary[letterKey] {
               let myFriend = friendsOnLetterKey[indexPath.row]

               cell.configure(
                   name: myFriend.fullName,
                   url: myFriend.photo)
           }
        return cell
    }
    
    func networkServiceFunction() {
        
        networkService.fetch(type: .friends) { [weak self] result in
            switch result {
            case .success(let responseFriends):
                    let items = responseFriends.map { UserRealm(user: $0) }
                    do {
                        try RealmService.save(items: items)
                        self?.friends = try RealmService.load(typeOf: UserRealm.self)
                    } catch {
                        print(error)
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortFriends() {
        guard let friends = friends
        else { return }
            for friend in friends where friend.firstName != "DELETED" {
                friendsDictionary.removeAll()
                
                for index in friends.indices {
                    let letterKey = String((friends[index].lastName).prefix(1))
                        if var friendsOnLetterKey = friendsDictionary[letterKey] {
                            friendsOnLetterKey.append(friends[index])
                            friendsDictionary[letterKey] = friendsOnLetterKey
                        } else {
                            friendsDictionary[letterKey] = [friends[index]]
                        }
                }
                
                friendsSectionTitles = [String](friendsDictionary.keys).sorted(by: { $0 < $1 })
            }
        
            self.friendsFilteredDictionary = self.friendsDictionary
            self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any? ) {
        
        guard segue.identifier == "goToFriend", let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let destination = segue.destination as? Friend else { return }
        let letterKey = friendsSectionTitles[indexPath.section]
           if let friendsOnLetterKey = friendsFilteredDictionary[letterKey] {
               destination.friend = friendsOnLetterKey[indexPath.row]
           }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(
                at: indexPath,
                animated: true)
        }
        performSegue(withIdentifier: "goToFriend", sender: nil)
    }
}

extension FriendsVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        
        searchBar.showsCancelButton = true
        guard !searchText.isEmpty else {
            friendsFilteredDictionary = friendsDictionary
            friendsSectionTitles = [String](friendsFilteredDictionary.keys).sorted()
            tableView.reloadData()
            return
        }

        friendsFilteredDictionary.removeAll()
        friendsSectionTitles.removeAll()

        for key in friendsDictionary.keys {
            guard let friend = friendsDictionary[key] else { return }
            friendsFilteredDictionary[key] = friend.filter({ $0.fullName.lowercased().contains(searchText.lowercased()) })
        }

        friendsSectionTitles = ([String](friendsFilteredDictionary.keys).sorted())
                                .filter({ !friendsFilteredDictionary[$0]!.isEmpty })
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
        friendsFilteredDictionary = friendsDictionary
        friendsSectionTitles = [String](friendsFilteredDictionary.keys).sorted()
        
        tableView.reloadData()
    }

    @objc func setSearchBar() {
        searchBar.searchTextField.text = "Search..."
        searchBar.showsCancelButton = true
    }
}
