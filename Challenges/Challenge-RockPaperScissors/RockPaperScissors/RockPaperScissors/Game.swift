//
//  Game.swift
//  RockPaperScissors
//
//  Created by Mikhail Medvedev on 18.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import Foundation


enum Move: String, CaseIterable {
    case rock, paper, scissors
}

struct Game {
    
    var round = 1 {
        didSet {
            randomMove = Move.allCases[Int.random(in: 0..<Move.allCases.count)]
            winCondition = Bool.random()
        }
    }
    
    var score = 0
    
    var randomMove = Move.allCases[Int.random(in: 0..<Move.allCases.count)]
    var winCondition = Bool.random()
    
    //game logic is here, nil == draw
    mutating func playerMoves(playerMove: Move) -> Bool? {
        print("compare game's \(randomMove) with player's \(playerMove) and condition is \(winCondition)")
        switch randomMove {
        case .rock:
            //game moves the rock
            if winCondition {
                //player need to win for score
                switch playerMove {
                case .rock: return draw()
                case .paper: return playerWin()
                case .scissors: return playerLose()
                }
            } else {
                //player need to lose for score
                switch playerMove {
                case .rock: return draw()
                case .paper: return playerLose()
                case .scissors: return playerWin()
                }
            }
        case .paper:
            //game moves the paper
            if winCondition {
                //player need to win for score
                switch playerMove {
                case .rock: return playerLose()
                case .paper: return draw()
                case .scissors: return playerWin()
                }
            } else {
                //player need to lose for score
                switch playerMove {
                case .rock: return playerWin()
                case .paper: return draw()
                case .scissors: return playerLose()
                }
            }
        case .scissors:
            //game moves the scissors
            if winCondition {
                //player need to win for score
                switch playerMove {
                case .rock: return playerWin()
                case .paper: return playerLose()
                case .scissors: return draw()
                }
            } else {
                //player need to lose for score
                switch playerMove {
                case .rock: return playerLose()
                case .paper: return playerWin()
                case .scissors: return draw()
                }
            }

        }

    }
    
    func show(result: Bool?) -> String {
        if let result = result {
            return result ? """
You win!
Score +1.
""" : """
You lose.
Score -1.
"""
        } else {
           return "Draw!"
        }
        
    }
    
    mutating func restart() {
        score = 0
        round = 1
    }
    
    fileprivate mutating func playerWin() -> Bool {
        //player wins
        score += 1
        round += 1
        return true
    }
    
    fileprivate mutating func playerLose() -> Bool {
        //player loses
        score -= 1
        round += 1
        return false
    }
    
    fileprivate mutating func draw() -> Bool? {
        //draw
        round += 1
        return nil
    }
    
}
