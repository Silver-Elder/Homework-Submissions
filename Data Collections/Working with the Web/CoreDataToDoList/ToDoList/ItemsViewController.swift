//
//  ViewController.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/15/22.
//

import UIKit

class ItemsViewController: UIViewController {
    
    let list: List
    
    init?(coder: NSCoder, list: List) {
        self.list = list
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum TableSection: Int {
        case incomplete, complete
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    private let itemManager = ItemManager.shared
    private lazy var datasource: ItemDataSource = {
        let datasource = ItemDataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reuseIdentifier) as! ItemTableViewCell
            cell.update(with: item)
            cell.delegate = self
            return cell
        }
        datasource.delegate = self
        return datasource
    }()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = datasource
        generateNewSnapshot()
    }

}


// MARK: - Item Cell Delegate

extension ItemsViewController: ItemCellDelegate {

    func completeButtonPressed(item: Item) {
        ItemManager.shared.toggleItemCompletion(item)
        generateNewSnapshot()
    }
    
}


// MARK: - ItemDelegate

extension ItemsViewController: ItemDelegate {
    
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = item(at: indexPath)
        itemManager.delete(itemToDelete)
        generateNewSnapshot()
    }
    
    func item(at indexPath: IndexPath) -> Item {
        let items = indexPath.section == 0 ? itemManager.fetchItems(of: list, completed: false) : itemManager.fetchItems(of: list, completed: true)
        return items[indexPath.row]
    }
    
}


// MARK: - TextField Delegate

extension ItemsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        itemManager.createNewItem(with: text, list: list)
        textField.text = ""
        generateNewSnapshot()
        return true
    }
    
}


// MARK: - Private

private extension ItemsViewController {
    
    func generateNewSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Item>()
        
        let incomleteItems = list.itemsArray.filter( {$0.isCompleted == false} )
        let completedItems = list.itemsArray.filter( {$0.isCompleted == true} )
        
        if !incomleteItems.isEmpty {
            snapshot.appendSections([.incomplete])
            snapshot.appendItems(incomleteItems, toSection: .incomplete)
        }
        if !completedItems.isEmpty {
            snapshot.appendSections([.complete])
            snapshot.appendItems(completedItems, toSection: .complete)
        }
        DispatchQueue.main.async {
            self.datasource.apply(snapshot)
        }
    }
    
}
