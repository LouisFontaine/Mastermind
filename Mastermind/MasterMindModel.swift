//
//  MasterMindModel.swift
//  Mastermind
//
//  Created by Louis Fontaine on 13/03/2019.
//  Copyright © 2019 Louis Fontaine. All rights reserved.
//

import Foundation

struct Constant {
    static let TIMER = 15
    static let NB_OF_ATEMPTS = 8
    static let NB_OF_CELLS = 4
}

class MasterMindModel {
    
    
    private(set)var gamingMode: gameMode
    private(set)var gamingState: gameState
    private(set)var board: [color]
    private(set)var solution: [color]
    private(set)var goodColors: [Int]
    private(set)var goodPlaces: [Int]
    private(set)var wins: Int
    private(set)var looses: Int
    private(set)var timer: Int
    private(set)var actualLevel: Int
    private(set)var actualCell: Int
    
    
    init() {
        self.gamingMode = gameMode.TRAINING
        self.gamingState = gameState.UNFINISHED
        self.board =
            [
                color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY
            ]
        self.solution =
            [
                color.randomColorExceptGrey(), color.randomColorExceptGrey(), color.randomColorExceptGrey(), color.randomColorExceptGrey()
            ]
        self.goodColors = [0, 0, 0, 0, 0, 0, 0, 0]
        self.goodPlaces = [0, 0, 0, 0, 0, 0, 0, 0]
        self.wins = 0
        self.looses = 0
        self.timer = Constant.TIMER
        self.actualLevel = 0
        self.actualCell = 0
    }
    
    func resetGame(newGamingMode: gameMode) {
        self.gamingMode = newGamingMode
        self.gamingState = gameState.UNFINISHED
        self.board =
            [
                color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY, color.GREY
        ]
        self.solution =
            [
                color.randomColorExceptGrey(), color.randomColorExceptGrey(), color.randomColorExceptGrey(), color.randomColorExceptGrey()
        ]
        self.goodColors = [0, 0, 0, 0, 0, 0, 0, 0]
        self.goodPlaces = [0, 0, 0, 0, 0, 0, 0, 0]
        self.timer = Constant.TIMER
        self.actualLevel = 0
        self.actualCell = 0
        
        print("Solution is : ")
        print(solution)
    }
    
    func setCellColor(buttonColor: String) {
        
        if actualLevel < Constant.NB_OF_ATEMPTS && actualCell < Constant.NB_OF_CELLS {
            if buttonColor == "PURPLE" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.PURPLE
            }
            else if buttonColor == "PINK" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.PINK
            }
            else if buttonColor == "YELLOW" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.YELLOW
            }
            else if buttonColor == "GREEN" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.GREEN
            }
            else if buttonColor == "BLUE" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.BLUE
            }
            else if buttonColor == "RED" {
                board[(actualLevel * Constant.NB_OF_CELLS) + actualCell] = color.RED
            }
            actualCell += 1
        }
    }
    
    func erase() {
        if actualCell != 0 {
            board[(actualLevel * Constant.NB_OF_CELLS) + actualCell - 1] = color.GREY
            actualCell -= 1
        }
    }
    
    func evaluate() {
        // If we are in pro mode, we need to reset the timer if the player has played
        if gamingMode == gameMode.PRO && actualCell == Constant.NB_OF_CELLS {
            resetTimer()
        }
        
        if actualCell == Constant.NB_OF_CELLS || self.timer == 0 {
            var nbPurpleSolution = 0
            var nbPinkSolution = 0
            var nbYellowSolution = 0
            var nbGreenSolution = 0
            var nbBlueSolution = 0
            var nbRedSolution = 0
            
            var nbPurpleEvaluate = 0
            var nbPinkEvaluate = 0
            var nbYellowEvaluate = 0
            var nbGreenEvaluate = 0
            var nbBlueEvaluate = 0
            var nbRedEvaluate = 0
            
            var nbPurpleInGoodPlace = 0
            var nbPinkInGoodPlace = 0
            var nbYellowInGoodPlace = 0
            var nbGreenInGoodPlace = 0
            var nbBlueInGoodPlace = 0
            var nbRedInGoodPlace = 0
            
            for i in 0..<Constant.NB_OF_CELLS {
                // Starting by evaluate the number of each color in the solution
                if game.solution[i] == color.PURPLE {
                    nbPurpleSolution += 1
                }
                else if game.solution[i] == color.PINK {
                    nbPinkSolution += 1
                }
                else if game.solution[i] == color.YELLOW {
                    nbYellowSolution += 1
                }
                else if game.solution[i] == color.GREEN {
                    nbGreenSolution += 1
                }
                else if game.solution[i] == color.BLUE {
                    nbBlueSolution += 1
                }
                else if game.solution[i] == color.RED {
                    nbRedSolution += 1
                }
                
                if (actualLevel * Constant.NB_OF_CELLS) + i < game.board.count {
                    // Then evaluate the number of each color in the userLine to evaluate
                    if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.PURPLE  {
                        nbPurpleEvaluate += 1
                    }
                    else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.PINK {
                        nbPinkEvaluate += 1
                    }
                    else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.YELLOW {
                        nbYellowEvaluate += 1
                    }
                    else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.GREEN {
                        nbGreenEvaluate += 1
                    }
                    else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.BLUE {
                        nbBlueEvaluate += 1
                    }
                    else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == color.RED {
                        nbRedEvaluate += 1
                    }
                }
               
                // Then evaluate the number of cells wich have the good color and the good place in the userLine to evaluate
                if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbPurpleInGoodPlace += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbPinkInGoodPlace += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbYellowInGoodPlace += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbGreenInGoodPlace += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbBlueInGoodPlace += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    nbRedInGoodPlace += 1
                }
            }
            
            // Calculate the number of cell with the good colors and the right places
            goodPlaces[actualLevel] += (nbPurpleInGoodPlace + nbPinkInGoodPlace + nbYellowInGoodPlace + nbGreenInGoodPlace + nbBlueInGoodPlace + nbRedInGoodPlace)
            
            // Declare if the game is win or loose
            if goodPlaces[actualLevel] == Constant.NB_OF_CELLS {
                gamingState = gameState.WON
                wins += 1
            }
            else if goodPlaces[actualLevel] < Constant.NB_OF_CELLS && actualLevel == 7 {
                gamingState = gameState.LOST
                looses += 1
            }
            
            // Calculate the number of cell with the right color but at the wrong place
            var nbPurpleGoodColorWrongPlace = 0
            if nbPurpleEvaluate > nbPurpleSolution {
                nbPurpleGoodColorWrongPlace = nbPurpleSolution
            }
            else {
                nbPurpleGoodColorWrongPlace = nbPurpleEvaluate
            }
            nbPurpleGoodColorWrongPlace -= nbPurpleInGoodPlace
            
            var nbPinkGoodColorWrongPlace = 0
            if nbPinkEvaluate > nbPinkSolution {
                nbPinkGoodColorWrongPlace = nbPinkSolution
            }
            else {
                nbPinkGoodColorWrongPlace = nbPinkEvaluate
            }
            nbPinkGoodColorWrongPlace -= nbPinkInGoodPlace
            
            var nbYellowGoodColorWrongPlace = 0
            if nbYellowEvaluate > nbYellowSolution {
                nbYellowGoodColorWrongPlace = nbYellowSolution
            }
            else {
                nbYellowGoodColorWrongPlace = nbYellowEvaluate
            }
            nbYellowGoodColorWrongPlace -= nbYellowInGoodPlace
            
            var nbGreenGoodColorWrongPlace = 0
            if nbGreenEvaluate > nbGreenSolution {
                nbGreenGoodColorWrongPlace = nbGreenSolution
            }
            else {
                nbGreenGoodColorWrongPlace = nbGreenEvaluate
            }
            nbGreenGoodColorWrongPlace -= nbGreenInGoodPlace
            
            var nbBlueGoodColorWrongPlace = 0
            if nbPurpleEvaluate > nbBlueSolution {
                nbBlueGoodColorWrongPlace = nbBlueSolution
            }
            else {
                nbBlueGoodColorWrongPlace = nbBlueEvaluate
            }
            nbBlueGoodColorWrongPlace -= nbBlueInGoodPlace
            
            var nbRedGoodColorWrongPlace = 0
            if nbRedEvaluate > nbRedSolution {
                nbRedGoodColorWrongPlace = nbRedSolution
            }
            else {
                nbRedGoodColorWrongPlace = nbRedEvaluate
            }
            nbRedGoodColorWrongPlace -= nbRedInGoodPlace
            
            goodColors[actualLevel] += nbPurpleGoodColorWrongPlace + nbPinkGoodColorWrongPlace + nbYellowGoodColorWrongPlace + nbGreenGoodColorWrongPlace + nbBlueGoodColorWrongPlace + nbRedGoodColorWrongPlace
            
            actualLevel += 1
            actualCell = 0
        }
    }
    
    func decreaseTimer() {
        if self.timer == 0 {
            actualCell = Constant.NB_OF_CELLS
            evaluate()
            resetTimer()
        }
        else {
            self.timer -= 1
        }
    }
    
    func resetTimer() {
        self.timer = Constant.TIMER
    }
    
    func resetWinsLooses() {
        self.wins = 0
        self.looses = 0
    }
    
    func addALoose() {
        self.looses += 1
    }
    
    func saveGameInLocalDataBase() {
        
    }
}

enum gameMode: String {
    case TRAINING, PRO
}

enum color: UInt32 {
    case PURPLE, PINK, YELLOW, GREEN, BLUE, RED, GREY
    
    private static let _count: color.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = color(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomColorExceptGrey() -> color {
        // pick and return a new value
        var aColor: color
        repeat {
            let rand = arc4random_uniform(_count)
            aColor = color(rawValue: rand)!
        } while aColor == color.GREY
        return aColor
    }
}

enum gameState: String {
    case UNFINISHED, WON, LOST
}
