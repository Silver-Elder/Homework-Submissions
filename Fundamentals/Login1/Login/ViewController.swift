//
//  ViewController.swift
//  Login
//
//  Created by Sterling Jenkins on 9/15/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var forgotUsername: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    
    @IBAction func forgotUsernameButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "Login View Controller", sender: sender)
    }
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "Login View Controller", sender: sender)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {
            return
        }
        
        if segue.identifier == "Login Button" {
        segue.destination.navigationItem.title = username.text
        } else if sender == forgotPassword {
            segue.destination.navigationItem.title = "Forgot Password"
        } else if sender == forgotUsername {
            segue.destination.navigationItem.title = "Forgot Username"
        }
    }


}

