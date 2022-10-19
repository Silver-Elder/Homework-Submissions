//
//  ViewController.swift
//  Tally App
//
//  Created by Sterling Jenkins on 9/30/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterButton.titleLabel?.textAlignment = .center
    }

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var prompt: UILabel!
    
    @IBAction func buttonPushed(_ sender: UIButton) {
        let error = "Hmm... I'm not sure what to do with that. My programmer only taught me how to add integer or decimal numbers to the counter; but if you you change your input to one of those values, I can add them for you!"
        
        guard var counterValue = Double(counter.text!) else { return }
        
        guard let userInput = userInput.text else { return }
        guard let userInput = Double(userInput) else { prompt.textColor = .red; prompt.text = error; return }
        
       counterValue += userInput
        
        if counterValue == Double(Int(counterValue)) {
            counter.text = "\(Int(counterValue))"
        } else {
            counter.text = "\(counterValue)"
        }
        
        
        if prompt.text == error || prompt.text == "How much do you want the counter to go up by?" {
            prompt.textColor = .black
            prompt.text = "How much do you want the counter to go up by now?"
        }
        
    }
    

}

