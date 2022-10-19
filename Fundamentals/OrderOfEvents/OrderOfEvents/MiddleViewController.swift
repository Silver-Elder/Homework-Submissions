//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by Sterling Jenkins on 9/19/22.
//

import UIKit

class MiddleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View did load")
        changeLabel(newText: "View did load")
    }
    
    @IBOutlet weak var nothingHasHappenedYet: UILabel!
    
    var eventNumber: Int = 1
    
    func changeLabel(newText: String) {
        if let oldText = nothingHasHappenedYet.text {
            nothingHasHappenedYet.text = "\(oldText)\nEvent number \(eventNumber) was \(newText)"
            eventNumber += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
        changeLabel(newText: "View will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View did appear")
        changeLabel(newText: "View did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View will disappear")
        changeLabel(newText: "View will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
        print("View did disappear")
        changeLabel(newText: "View did disappear")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
