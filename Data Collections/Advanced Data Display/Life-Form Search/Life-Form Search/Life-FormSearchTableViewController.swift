//
//  Life-FormSearchTableViewController.swift
//  Life-Form Search
//
//  Created by Sterling Jenkins on 1/20/23.
//

import UIKit

class Life_FormSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchResults: [GeneralSearchResult] = []
    var searchController = UISearchController()
    
    var itemsSnapshot: NSDiffableDataSourceSnapshot<String, GeneralSearchResult> {
        var snapshot = NSDiffableDataSourceSnapshot<String, GeneralSearchResult>()
        
        snapshot.appendSections(["Results"])
        snapshot.appendItems(searchResults)
        
        return snapshot
    }
    
    var tableViewDataSource: UITableViewDiffableDataSource<String, GeneralSearchResult>!
    
    var searchTask: Task<Void, Never>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.showsScopeBar = true
        
        configureTableViewDataSource(self.tableView)
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchMatchingItems), object: nil)
        perform(#selector(fetchMatchingItems), with: nil, afterDelay: 0.3)
    }
    
    
    
    @objc func fetchMatchingItems() {
        
        self.searchResults = []
        
        let searchTerm = searchController.searchBar.text ?? ""
        
        searchTask?.cancel()
        searchTask = Task {
            if !searchTerm.isEmpty {
                
                let request = GeneralSearchAPIRequest(apiKey: searchTerm)
                
                // use the item controller to fetch items
                do {
                    // use the item controller to fetch items
                    let search = try await generalSendRequest(request)
                    if searchTerm == self.searchController.searchBar.text {
                        self.searchResults = search.results
                    }
                } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                    // ignore cancellation errors
                } catch {
                    // otherwise, print an error to the console
                    print(error)
                }
                // apply data source changes
                await tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
            } else {
                // apply data source changes
                await tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
            }
            
            
            searchTask = nil
        }
    }
    
    func configureTableViewDataSource(_ tableView: UITableView) {
        tableViewDataSource = UITableViewDiffableDataSource<String, GeneralSearchResult>(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)

            var contentConfiguration = cell.defaultContentConfiguration()
            
            contentConfiguration.text = item.content
            contentConfiguration.secondaryText = item.title
            
            cell.contentConfiguration = contentConfiguration
            
            return cell
        })
    }
    
    @IBSegueAction func toDetailedProfile(_ coder: NSCoder, sender: Any?) -> SearchResultDisplayViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell) else {
            print("failed")
            return nil
        }
        
        let item = searchResults[indexPath.row]
        
        return SearchResultDisplayViewController(coder: coder, item: item, navigationTitle: item.content ?? "Loading...")
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
        
        let searchResult = searchResults[indexPath.row]

        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = searchResult.content
        contentConfiguration.secondaryText = searchResult.title

        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
