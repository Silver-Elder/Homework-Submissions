//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Sterling Jenkins on 10/5/22.
//

import UIKit

class ResultsViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
        }
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefninitionLabel: UILabel!
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [:]) { //"[:]" is an empty dictionary
            (counts, answer) in
            counts[answer.type, default: 0] += 1 //counts is defined here as being an array of answer.type values, and is given a default value to tell the reduce function what in index value of "counts" is (referring to "(counts, answer), which is the index and value names for your empty dictionary), if our 'counts' array has no value. I"m not sure what the '+= 1' on the end is about, though.
        }
        
//        let sortedAnswers = frequencyOfAnswers.sorted(by: { (pair1, pair2) in
//            return pair1.value > pair2.value
//        })
//        let mostCommonAnswer = sortedAnswers.first!.key
        
        // ^^^ This can all be simplified down into... vvv
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefninitionLabel.text = mostCommonAnswer.definition

    }
    
    @IBAction func dismissPersonalityQuizModalPresentation(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
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
