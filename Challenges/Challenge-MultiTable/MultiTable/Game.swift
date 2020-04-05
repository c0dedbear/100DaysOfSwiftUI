//
//  Game.swift
//  MultiTable
//
//  Created by Mikhail Medvedev on 28.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation

struct Game {
    
    let numbers = [1,2,3,4,5,6,7,8,9,10]
    
    var currentNumber: Int?
	var currentMultiplier: Int?
    
    func checkAnswer(input: Int) -> Bool {
		guard let number = currentNumber, let multiplier = currentMultiplier else { return false }
		print(input == number * multiplier)
        return input == number * multiplier
    }
    
    func generateAnswers(number: Int, multiplier: Int) -> [String:[Int]] {
        let rightAnswer = number * multiplier
		var set = Set<Int>()

		for _ in 0...2 {
			let randomInt = number * Int.random(in: 1...10)
				if randomInt != rightAnswer {
				   set.insert(randomInt)
				} else {
					set.insert(0)
				}
        }
		
		let wrongAnswers = Array(set)
        return ["right" : [rightAnswer], "wrong" : wrongAnswers]
    }

	mutating func setMultiplier() {
		currentMultiplier = Int.random(in: 1...10)
	}
    
}
