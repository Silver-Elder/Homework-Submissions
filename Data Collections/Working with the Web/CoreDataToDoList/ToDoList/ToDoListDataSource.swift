//
//  ToDoListController.swift
//  ToDoist
//
//  Created by Sterling Jenkins on 12/15/22.
//

import Foundation
import UIKit

protocol ListDelegate {
    func deleteList(at indexPath: IndexPath)
}

class ListDataSource: UITableViewDiffableDataSource<ToDoListViewController.TableSection, List> {
    
    var delegate: ListDelegate?
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = ToDoListViewController.TableSection(rawValue: section)!
        switch tableSection {
        case .lists:
            return "Lists"
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        delegate?.deleteList(at: indexPath)
    }
    
}
