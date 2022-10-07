//
//  ViewController.swift
//  Personality Quiz
//
//  Created by Sterling Jenkins on 10/5/22.
//

import UIKit

class IntroductionViewController: UIViewController {

    @IBOutlet weak var quizStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quizStartButton.layer.cornerRadius = quizStartButton.bounds.height / 2
        quizStartButton.titleLabel?.textAlignment = .center
    }


}

