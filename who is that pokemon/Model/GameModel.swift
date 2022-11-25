//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Lucas Suarez Blanco on 11/15/22.
//

import Foundation


struct GameModel {
    var score = 0
    mutating func checkAnswer(userAnswer: String, correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            score += 1
            return true
        }
        return false
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func setScore(score: Int) -> Void {
        self.score = score
    }
}
