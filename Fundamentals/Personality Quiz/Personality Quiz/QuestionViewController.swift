//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Sterling Jenkins on 10/5/22.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
   
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var questionLabel3: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
        @IBOutlet weak var singleButton1: UIButton!
        @IBOutlet weak var singleButton2: UIButton!
        @IBOutlet weak var singleButton3: UIButton!
        @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
        @IBOutlet weak var mulitLabel1: UILabel!
        @IBOutlet weak var mulitLabel2: UILabel!
        @IBOutlet weak var mulitLabel3: UILabel!
        @IBOutlet weak var mulitLabel4: UILabel!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var quizProgressView: UIProgressView!
    
    //---------------------------------------
    
    var questionsAnswered = 0
    var answersChosen: [Answer] = []
    
    func nextQuestion() {
        questionsAnswered += 1
        
        if questionsAnswered < questions.count {
            updateUI()
        }
        
        else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    //---------------------------------------
    
    @IBAction func singeAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionsAnswered].answers
        
        switch sender {
            case singleButton1:
                answersChosen.append(currentAnswers[0])
                
            case singleButton2:
                answersChosen.append(currentAnswers[1])
                
            case singleButton3:
                answersChosen.append(currentAnswers[2])
                
            case singleButton4:
                answersChosen.append(currentAnswers[3])
                
            default:
                break
        }
        
        nextQuestion()
    }
   
    //----------------------------------------
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBAction func multipleAnswerSubmitButtonPressed() {
        let currentAnswers = questions[questionsAnswered].answers
        
        if multiSwitch1.isOn {
                answersChosen.append(currentAnswers[0])
        }
                
        if multiSwitch2.isOn {
                answersChosen.append(currentAnswers[1])
        }
                
        if multiSwitch3.isOn {
                answersChosen.append(currentAnswers[2])
        }
                
        if multiSwitch4.isOn {
                answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    //----------------------------------------
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBAction func rangedAnswerSubmitButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionsAnswered].answers
        let sliderrange = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[sliderrange])
        
        nextQuestion()
    }
    
    //----------------------------------------
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        //--------------------------
        
        navigationItem.title = "Qestion #\(questionsAnswered + 1)"
       
        //--------------------------
        
        let totalProgress = Float(questionsAnswered) / Float(questions.count)
     
        quizProgressView.setProgress(totalProgress, animated: true)
        
        //--------------------------
        
        let questionToDisplay = questions[questionsAnswered]
        let currentQuestionAnswers = questionToDisplay.answers
        
        switch questionToDisplay.type {
        case .single:
            updateSingleStack(using: currentQuestionAnswers)
            questionLabel.text = questionToDisplay.text
        case .multiple:
            updateMultipleStack(using: currentQuestionAnswers)
            questionLabel2.text = questionToDisplay.text
        case .ranged:
            updateRangedStack(using: currentQuestionAnswers)
            questionLabel3.text = questionToDisplay.text
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        mulitLabel1.text = answers[0].text
        mulitLabel2.text = answers[1].text
        mulitLabel3.text = answers[2].text
        mulitLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedSlider.setValue(0.5, animated: false)
        
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    var questions: [Question] = [
        
        Question(
            text: "Which food do you like most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
             ]
        ),
        
        Question(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
             ]
        ),
        
        Question(
            text: "How much do you enjoy car rides?",
            type: .ranged,
            answers: [
                Answer(text: "I quite diliske them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I LOVE them", type: .dog)
             ]
        )
        
    ]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
