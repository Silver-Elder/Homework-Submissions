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
               // self.emailTextField.layer.cornerRadius = CGFloat(self.emailTextField.heightAnchor.hashValue * 2)
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 1
                
                //Create concatenated transformations for left and right movement
                        //Acutally, that might only work with the "UIView.animateKeyFrames" feature, but we haven't learned about that yet
                
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

