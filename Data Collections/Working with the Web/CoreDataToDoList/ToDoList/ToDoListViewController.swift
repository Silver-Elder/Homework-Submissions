//
//  ToDoListViewController.swift
//  ToDoist
//
//  Created by Sterling Jenkins on 12/14/22.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    enum TableSection: Int {
        case lists
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        var listName: String = ""
        
        let alertController = UIAlertController(title: "List Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        
        let alertSubmitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alertController] _ in
            if let answer = alertController.textFields?[0].text {
                listName = answer
            }
            
            self.performSegue(withIdentifier: "New List", sender: self.listManager.createNewList(with: listName))
        }
        alertController.addAction(alertSubmitAction)
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(alertCancelAction)
        
        present(alertController, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = datasource
        generateNewSnapshot()
    }
    
    private let listManager = ListManager.shared
    
    private lazy var datasource: ListDataSource = {
        let datasource = ListDataSource(tableView: tableView) { tableView, indexPath, list in
            let cell = tableView.dequeueReusableCell(withIdentifier: "List")
            var configuration = cell?.defaultContentConfiguration()
            configuration?.text = list.title
            configuration?.secondaryText = "Items To Do: \(list.itemsArray.count)"
            
            return cell
        }
        datasource.delegate = self
        return datasource
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBSegueAction func segueToList(_ coder: NSCoder, sender: Any?) -> ItemsViewController? {
        if let indexPath = tableView.indexPathForSelectedRow {
            let list = listManager.list(at: indexPath)
            return ItemsViewController(coder: coder, list: list)
        } else {
            return ItemsViewController(coder: coder, list: sender as! List)
        }
    }

}

// MARK: - List Delegate

extension ToDoListViewController: ListDelegate {
    func deleteList(at indexPath: IndexPath) {
        ListManager.shared.delete(at: indexPath)
    }
}

// MARK: - (Private) Snapshot

private extension ToDoListViewController {
    
    func generateNewSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, List>()
        
        let lists = listManager.fetchLists()
        
        if !lists.isEmpty {
            snapshot.appendSections([.lists])
            snapshot.appendItems(lists, toSection: .lists)
        }
        
        DispatchQueue.main.async {
            self.datasource.apply(snapshot)
        }
        
    }
}
