//
//  ViewController.swift
//  Calculator
//
//  Created by Sterling Jenkins on 9/2/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var Display: UILabel!
    
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
    
    @IBOutlet var numberPad: [UIButton]!
    
    
    
    
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
    
    var firstValue: Double = 0
    var operation = ""
    
    let divide: (Double, Double) -> Double = (/)
    let multiply: (Double, Double) -> Double = (*)
    let add: (Double, Double) -> Double = (+)
    let subtract: (Double, Double) -> Double = (-)
    
//    let numberPad2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
//    let operators = ["AC", "+/=", "%"]
    
//    func updateLabelValue() {
//        if let display = Display.text {
//            if let display = Double(display) {
//                labelValue = display
//            }
//        }
//    }
    
    @IBAction func numberTapped(_ sender: UIButton) {
//        calculatedValue = Int(sender.titleLabel?.text)
        
        if Display.text == "0" {
            if sender.titleLabel?.text == "." {
                (Display.text)! += (sender.titleLabel?.text)!
            } else {
            (Display.text)! = (sender.titleLabel?.text)!
            }
        } else if sender.titleLabel?.text == "." {
            if (Display.text)!.contains(".") {
                print("Display already contains a decimal.")
            } else {
                (Display.text)! += (sender.titleLabel?.text)!
                }
        } else {
                (Display.text)! += (sender.titleLabel?.text)!
        }
        
    }
        
    
    @IBAction func functionTapped(_ sender: UIButton) {
    
        switch sender.titleLabel?.text {
            case "AC":
                firstValue = 0
                operation = ""
                (Display.text)! = "0"
                
                PercentageButton.backgroundColor = .darkGray;
                DivisionButton.backgroundColor = .orange;
                DivisionButton.tintColor = .white;
                MultiplicationButton.backgroundColor = .orange;
                MultiplicationButton.tintColor = .white;
                SubtractionButton.backgroundColor = .orange;
                SubtractionButton.tintColor = .white;
                AdditionButton.backgroundColor = .orange;
                AdditionButton.tintColor = .white
            case "+/-":
                if (Display.text)!.contains("-") {
                    (Display.text)!.remove(at: (Display.text)!.startIndex)
                } else {
                    Display.text = "-" + Display.text!
                }
            case "%":
                Display.text = "\(divide((Double((Display.text)!))!, 100))"
//
                
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
                firstValue = ((Double((Display.text)!))!)
                operation = "/"
                Display.text = "0"

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
                firstValue = ((Double((Display.text)!))!)
                operation = "*"
                Display.text = "0"
            
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
                firstValue = ((Double((Display.text)!))!)
                operation = "-"
                Display.text = "0"
            
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
                firstValue = ((Double((Display.text)!))!)
                operation = "+"
                Display.text = "0"
            
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
                if operation == "/" {
                    Display.text = "\(divide(firstValue, (Double((Display.text)!))!))"
                } else if operation == "*" {
                    Display.text = "\(multiply(firstValue, (Double((Display.text)!))!))"
                } else if operation == "+" {
                    Display.text = "\(add(firstValue, (Double((Display.text)!))!))"
                } else if operation == "-" {
                    Display.text = "\(subtract(firstValue, (Double((Display.text)!))!))"
                }
                
                firstValue = 0
                operation = ""
            
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
                numberTapped(sender)
        }
    }

}
