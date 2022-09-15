//
//  ViewController.swift
//  What is this?
//
//  Created by Sterling Jenkins on 9/1/22.
//

import UIKit

class InterfaceBuilderExampleViewController: UIViewController {
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
   ///

    @IBAction func switched(_ sender: UISwitch) {
        if sender.isOn == false {
            sender.thumbTintColor = .yellow
        } else {
            sender.thumbTintColor = .white
        }
    }
    
    @IBAction func silderSlided(_ sender: UISlider) {
        if sender.value > 0.5 {
            self.view.backgroundColor = .red
        } else {
            self.view.backgroundColor = .purple
        }
    }
    
    @IBAction func newLetterEntered(_ sender: UITextField) {
            if let text = sender.text {
                print("New letter entered: \(text)")
            }
        }
}

