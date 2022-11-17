//
//  PlayerListTableViewController.swift
//  Score Keeper App
//
//  Created by Sterling Jenkins on 11/15/22.
//

import UIKit

class PlayerListTableViewController: UITableViewController, PlayerCellDelegate {
    
    func stepperValueChanged(sender: PlayerTableViewCell, stepperValue: UIStepper) {
        if let indexPath = tableView.indexPath(for: sender) {
            var player = players[indexPath.row]
            player.score = Int(stepperValue.value)
            players[indexPath.row] = player
            
            players = players.sorted(by: <)
            tableView.reloadData()
            Player.savePlayers(players)
        }
    }

    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedPlayers = Player.loadPlayers() {
            players = savedPlayers.sorted(by: <)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Player Cell", for: indexPath) as! PlayerTableViewCell
        
        let player = players[indexPath.row]
        
        cell.playerNameLabel.text = player.name
        cell.playerScoreStepper.value = Double(player.score)
        cell.playerScoreLabel.text = "\(player.score)"
        
        cell.cellDelegate = self

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Player.savePlayers(players)
        }
    }
    
    @IBSegueAction func addOrEditPlayer(_ coder: NSCoder, sender: Any?) -> PlayerProfileViewController? {
        let playerDetailController = PlayerProfileViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return playerDetailController
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        playerDetailController?.player = players[indexPath.row]
        
        return playerDetailController
    }
    
    @IBAction func unwindToPlayerList(segue: UIStoryboardSegue) {
        guard segue.identifier == "Unwind to Player List" else { return }
        let sourceViewController = segue.source as! PlayerProfileViewController
        
        if let player = sourceViewController.player {
            if let origionalPlayerCellIndex = players.firstIndex(of: player) {
                players[origionalPlayerCellIndex] = player
                players = players.sorted(by: <)
                tableView.reloadData()
            } else {
                let newindexPath = IndexPath(row: players.count, section: 0)
                players.append(player)
                tableView.insertRows(at: [newindexPath], with: .automatic)
                players = players.sorted(by: <)
                tableView.reloadData()
            }
        }
        
        Player.savePlayers(players)
        
    }

}
