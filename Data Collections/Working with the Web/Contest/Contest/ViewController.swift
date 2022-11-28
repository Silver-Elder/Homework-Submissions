//
//  ViewController.swift
//  Contest
//
//  Created by Sterling Jenkins on 11/23/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true {
            UIView.animate(withDuration: 0.1) {
                self.emailTextField.tintColor = .red
                //Create concatenated transformations for left and right movement
                
                self.emailTextField.transform = CGAffineTransform(translationX: 16, y: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.emailTextField.transform = .identity
                }
            }
        } else {
            performSegue(withIdentifier: "Submit Segue", sender: nil)
        }
    }
    
}

