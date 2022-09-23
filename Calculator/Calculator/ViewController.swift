//
//  ViewController.swift
//  Calculator
//
//  Created by Sterling Jenkins on 9/2/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var Display: UILabel!
    
    var calculatedValue = 0
    
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var PositiveOrNegativeButton: UIButton!
    @IBOutlet weak var PercentageButton: UIButton!
    
    @IBOutlet weak var DivisionButton: UIButton!
    @IBOutlet weak var MultiplicationButton: UIButton!
    @IBOutlet weak var SubtractionButton: UIButton!
    @IBOutlet weak var AdditionButton: UIButton!
    @IBOutlet weak var EqualsButton: UIButton!
    @IBOutlet weak var DecimalPointButton: UIButton!
    
    @IBOutlet weak var ZeroButton: UIButton!
    @IBOutlet weak var OneButton: UIButton!
    @IBOutlet weak var TwoButton: UIButton!
    @IBOutlet weak var ThreeButton: UIButton!
    @IBOutlet weak var FourButton: UIButton!
    @IBOutlet weak var FiveButton: UIButton!
    @IBOutlet weak var SixButton: UIButton!
    @IBOutlet weak var SevenButton: UIButton!
    @IBOutlet weak var EightButton: UIButton!
    @IBOutlet weak var NineButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CButton.layer.cornerRadius = CButton.bounds.height / 2.1
        PositiveOrNegativeButton.layer.cornerRadius = PositiveOrNegativeButton.bounds.height / 2.1
        PercentageButton.layer.cornerRadius = PercentageButton.bounds.height / 2.1
        
        DivisionButton.layer.cornerRadius = DivisionButton.bounds.height / 2.1
        MultiplicationButton.layer.cornerRadius = MultiplicationButton.bounds.height / 2.1
        SubtractionButton.layer.cornerRadius = SubtractionButton.bounds.height / 2.1
        AdditionButton.layer.cornerRadius = AdditionButton.bounds.height / 2.1
        EqualsButton.layer.cornerRadius = EqualsButton.bounds.height / 2.1
        DecimalPointButton.layer.cornerRadius = DecimalPointButton.bounds.height / 2.1
            
        ZeroButton.layer.cornerRadius = ZeroButton.bounds.height / 2.1
        OneButton.layer.cornerRadius = OneButton.bounds.height / 2.1
        TwoButton.layer.cornerRadius = TwoButton.bounds.height / 2.1
        ThreeButton.layer.cornerRadius = ThreeButton.bounds.height / 2.1
        FourButton.layer.cornerRadius = FourButton.bounds.height / 2.1
        FiveButton.layer.cornerRadius = FiveButton.bounds.height / 2.1
        SixButton.layer.cornerRadius = SixButton.bounds.height / 2.1
        SevenButton.layer.cornerRadius = SevenButton.bounds.height / 2.1
        EightButton.layer.cornerRadius = EightButton.bounds.height / 2.1
        NineButton.layer.cornerRadius = NineButton.bounds.height / 2.1
    }
    
    @IBAction func ClearAction(_ sender: Any) {
    }
    @IBAction func PositiveOrNegativeAction(_ sender: Any) {
    }
    @IBAction func PercentageAction(_ sender: Any) {
    }
    
    @IBAction func DivisionAction(_ sender: Any) {
    }
    @IBAction func MultiplicationAction(_ sender: Any) {
    }
    @IBAction func SubtractionButton(_ sender: Any) {
    }
    @IBAction func AdditionAction(_ sender: Any) {
        CButton.titleLabel?.text = "C"
    }
    @IBAction func EqualsAction(_ sender: Any) {
    }
    @IBAction func DecimalActon(_ sender: Any) {
    }
    
    @IBAction func numberTapped(_ sender: UIButton) {
//        calculatedValue = Int(sender.titleLabel?.text)
        if Display.text == "0" {
            if sender.titleLabel?.text == "." {
                (Display.text)! += (sender.titleLabel?.text)!
            } else {
            (Display.text)! = (sender.titleLabel?.text)!
            }
        } else {
        (Display.text)! += (sender.titleLabel?.text)!
        }
        
    }
    
    @IBAction func functionTapped(_ sender: UIButton) {
    
        switch sender.titleLabel?.text {
            case "AC":
                (Display.text)! = "0"
            case "+/-":
                if (Display.text)!.contains("-") {
                    (Display.text)!.remove(at: (Display.text)!.startIndex)
                } else {
                    Display.text = "-" + Display.text!
                }
           
            
            case "%":
                PercentageButton.backgroundColor = .white;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
            
            case "/":
                DivisionButton.backgroundColor = .white;
                DivisionButton.tintColor = .black;
                PercentageButton.backgroundColor = .darkGray;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
            
            case "x":
                MultiplicationButton.backgroundColor = .white;
                MultiplicationButton.tintColor = .black;
                PercentageButton.backgroundColor = .darkGray;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
                
            case "-":
                SubtractionButton.backgroundColor = .white;
                SubtractionButton.tintColor = .black;
                PercentageButton.backgroundColor = .darkGray;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
                
            case "+":
                AdditionButton.backgroundColor = .white;
                AdditionButton.tintColor = .black;
                PercentageButton.backgroundColor = .darkGray;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                
            case "=":
                PercentageButton.backgroundColor = .darkGray;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
            default:
            numberTapped(UIButton)
        }
    }

}
