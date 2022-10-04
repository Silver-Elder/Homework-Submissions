//
//  ViewController.swift
//  Text Validation App
//
//  Created by Sterling Jenkins on 10/3/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    func error(_ value: Bool) {
        if value == true {
            errorLabel.textColor = .red
            errorLabel.text = "Your Password must be at least 8 characters long, and contain at least 1 special character (,.!@#$%^&*<>?+=-), and both one uppercase and one lowercase letter."
        } else {
            errorLabel.textColor = .green
            errorLabel.text = "You've set a valid password!"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == password {
            passwordValidation()
        }
        return true
    }
    
    
    func passwordValidation() {
        if let password = password.text?.count {
            guard (password >= 8) else {
                return error(true)
            }
        }
        
        
        let specialChar = CharacterSet(charactersIn: ",.!@#$%^&*<>?+=-")
        
        if let password = password.text {
            guard password.rangeOfCharacter(from: specialChar) != nil else {
                return error(true)
            }
        }
        
        var uppercase = false
        var lowercase = false
        
        if let password = password.text {
            for (_, char) in password.enumerated() {
                let specialChar = ",.!@#$%^&*<>?+=- "
                let numbers = "0123456789"
                let charCheck: Bool = !specialChar.contains(char) && !numbers.contains(char)
                
                if charCheck == true {
                    if "\(char)".uppercased() == "\(char)" {
                        uppercase = true
                    } else if "\(char)".lowercased() == "\(char)" {
                        lowercase = true
                    }
                }
            }
        }
        
        if uppercase == true && lowercase == true {
            error(false)
        } else {
            error(true)
        }
        
    }
    
//    let string: String = "ASt3r1!ng"
//
//    var uppercase = false
//    var lowercase = false
//
//
//    for (_, char) in string.enumerated() {
//        print(char)
//        if "\(char)".uppercased() == "\(char)" {
//            print("Uppercase: \(char)")
//            uppercase = true
//        } else if "\(char)".lowercased() == "\(char)" {
//            print("Lowercase: \(char)")
//            lowercase = true
//        }
//    }
//
//    print(uppercase)
//    print(lowercase)

}

