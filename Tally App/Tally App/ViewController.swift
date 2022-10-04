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


}

