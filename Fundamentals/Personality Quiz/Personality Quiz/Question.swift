//
//  Question.swift
//  Personality Quiz
//
//  Created by Sterling Jenkins on 10/5/22.
//

import Foundation
import UIKit

struct Question {
    var text: String
    var type: QuestionLayout
    var answers: [Answer]
}

enum QuestionLayout {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: Animal
    
    enum Animal: Character {
        case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
        var definition: String {
            switch self {
            case .dog:
                return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
            case .cat:
                return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
            case .rabbit:
                return "You love everything that’s soft. You are healthy and full of energy."
            case .turtle:
                return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
            }
        }
    }
}
