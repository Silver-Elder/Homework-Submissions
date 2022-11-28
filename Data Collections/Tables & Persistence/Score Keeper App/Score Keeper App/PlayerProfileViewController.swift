//
//  PlayerProfileViewController.swift
//  Score Keeper App
//
//  Created by Sterling Jenkins on 11/15/22.
//

import UIKit

class PlayerProfileViewController: UIViewController {

    var player: Player?
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var currentScoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if let player = player {
            navigationItem.title = "\(player.name)"
            playerNameTextField.text = player.name
            currentScoreTextField.text = "\(player.score)"
        } else {
            navigationItem.title = "New Player"
        }
        
        updateSaveButton()
    }
    
// MARK: - Save Button State
    
    func updateSaveButton() {
        let shouldEndableSaveButton = playerNameTextField.text?.isEmpty != true && Int(currentScoreTextField.text ?? "") != nil
        saveButton.isEnabled = shouldEndableSaveButton
    }
    
    @IBAction func playerNameTextFieldEditingChanged() {
        updateSaveButton()
    }
    @IBAction func currentScoreTextFieldEditingChanged() {
        updateSaveButton()
    }
    
// MARK: - Resign Keyboard
    
    @IBAction func playerNameTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func currentScoreReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            guard segue.identifier == "Unwind to Player List" else { return }
        
        let name = playerNameTextField.text!
        let score = Int(currentScoreTextField.text!)!
        
        if player != nil {
            player?.name = name
            player?.score = score
        } else {
            player = Player(name: name, score: score)
        }
    }
}
