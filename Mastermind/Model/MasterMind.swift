//
//  MasterMindModel.swift
//  Mastermind
//
//  Created by Louis Fontaine on 13/03/2019.
//  Copyright © 2019 Louis Fontaine. All rights reserved.
//

import Foundation

// Different constant used in the Mastermind class
struct Constant {
    static let TIMER = 15
    static let NB_OF_ATEMPTS = 8
    static let NB_OF_CELLS = 4
}

class MasterMind : Codable {
    
    
    private(set)var gamingMode: gameMode // Training or Pro
    private(set)var gamingState: gameState // Unifinished or won or lost
    private(set)var board: [color] // An array of "color"  representing all the cells of a mastermind board
    private(set)var solution: [color] // An array of "color" representing all the cells of the game' solution
    private(set)var goodColors: [Int] // Number of cells who have a color which is in the solution
    private(set)var goodPlaces: [Int] // Number of cells who have a good color at the good place in the solution
    private(set)var wins: Int // Number of win in the historic
    private(set)var looses: Int // Number of loose  in the historic
    private(set)var timer: Int // Store the time in second before you loose the attempt
    private(set)var actualLevel: Int // the actual attempt of the game
    private(set)var actualCell: Int // The next cell the player is comming to fill
    
    // Initialize a Mastermind game, withe a game mode and a number of previous wins and previous looses
    init(newGamingMode: gameMode, wins: Int, looses: Int) {
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
        if games.count > 0 {
            self.wins = games[games.count - 1].wins
            self.looses = games[games.count - 1].looses
        }
        self.actualLevel = 0
        self.actualCell = 0
        self.wins = wins
        self.looses = looses
        
        print("Solution is : ")
        print(solution)
    }
    
    //  Set the color of the actual cell
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
    
    // Erase the previous cell the user entered
    func erase() {
        if actualCell != 0 {
            board[(actualLevel * Constant.NB_OF_CELLS) + actualCell - 1] = color.GREY
            actualCell -= 1
        }
    }
    
    // Evaluate the attempt
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
            
            self.goodPlaces[actualLevel] = 0
            
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
                    self.goodPlaces[actualLevel] += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    self.goodPlaces[actualLevel] += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    self.goodPlaces[actualLevel] += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    self.goodPlaces[actualLevel] += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    self.goodPlaces[actualLevel] += 1
                }
                else if game.board[(actualLevel * Constant.NB_OF_CELLS) + i] == solution[i] {
                    self.goodPlaces[actualLevel] += 1
                }
            }
            
            // Calculate the number of cell with the good colors and the wrong place
            goodColors[actualLevel] += min(nbPurpleSolution, nbPurpleEvaluate)
            goodColors[actualLevel] += min(nbPinkSolution, nbPinkEvaluate)
            goodColors[actualLevel] += min(nbYellowSolution, nbYellowEvaluate)
            goodColors[actualLevel] += min(nbGreenSolution, nbGreenEvaluate)
            goodColors[actualLevel] += min(nbBlueSolution, nbBlueEvaluate)
            goodColors[actualLevel] += min(nbRedSolution, nbRedEvaluate)
            goodColors[actualLevel] -= goodPlaces[actualLevel]
            
            if goodPlaces[actualLevel] == Constant.NB_OF_CELLS {
                self.gamingState = gameState.WON
                self.wins += 1
            }
            else if actualLevel >= Constant.NB_OF_ATEMPTS {
                self.gamingState = gameState.LOST
                self.looses += 1
            }
            
            actualLevel += 1
            actualCell = 0
        }
    }
    
    // Function used when the timmer decrease of 1
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
    
    // Function used to reset the timer
    func resetTimer() {
        self.timer = Constant.TIMER
    }
    
    // Fuction used to reset the number of wins and looses
    func resetWinsLooses() {
        self.wins = 0
        self.looses = 0
    }
    
    // Fuction used to add a loose
    func addALoose() {
        self.looses += 1
        self.gamingState = gameState.LOST
    }
    
    // Used to implement Codable
    enum Keys: String {
        case gamingMode = "gamingMode"
        case gamingState = "gamingState"
        case board = "board"
        case solution = "solution"
        case goodColors = "goodColors"
        case goodPlaces = "goodPlaces"
        case wins = "wins"
        case looses = "looses"
        case timer = "timer"
        case actualLevel = "actualLevel"
        case actualCell = "actualCell"
    }
    
    // Used to implement Codable
    func encode(with aCoder: NSCoder) {
        aCoder.encode(gamingMode, forKey: Keys.gamingMode.rawValue)
        aCoder.encode(gamingState, forKey: Keys.gamingState.rawValue)
        aCoder.encode(board, forKey: Keys.board.rawValue)
        aCoder.encode(solution, forKey: Keys.solution.rawValue)
        aCoder.encode(goodColors, forKey: Keys.goodColors.rawValue)
        aCoder.encode(goodPlaces, forKey: Keys.goodPlaces.rawValue)
        aCoder.encode(wins, forKey: Keys.wins.rawValue)
        aCoder.encode(looses, forKey: Keys.looses.rawValue)
        aCoder.encode(timer, forKey: Keys.timer.rawValue)
        aCoder.encode(actualCell, forKey: Keys.actualCell.rawValue)
    }
    
    // Used to implement Codable
    required convenience init?(coder aDecoder: NSCoder) {
        let gamingMode = aDecoder.decodeObject(forKey: Keys.gamingMode.rawValue) as! gameMode
        let gamingState = aDecoder.decodeObject(forKey: Keys.gamingState.rawValue) as! gameState
        let board = aDecoder.decodeObject(forKey: Keys.board.rawValue) as? [color] ?? []
        let solution = aDecoder.decodeObject(forKey: Keys.solution.rawValue) as? [color] ?? []
        let goodColors = aDecoder.decodeObject(forKey: Keys.goodColors.rawValue) as! [Int]
        let goodPlaces = aDecoder.decodeObject(forKey: Keys.goodPlaces.rawValue) as! [Int]
        let wins = aDecoder.decodeObject(forKey: Keys.wins.rawValue) as! Int
        let looses = aDecoder.decodeObject(forKey: Keys.looses.rawValue) as! Int
        let timer = aDecoder.decodeObject(forKey: Keys.timer.rawValue) as! Int
        let actualLevel = aDecoder.decodeObject(forKey: Keys.actualLevel.rawValue) as! Int
        let actualCell = aDecoder.decodeObject(forKey: Keys.actualCell.rawValue) as! Int
        self.init(gamingMode_: gamingMode, gamingState_: gamingState, board_: board, solution_: solution, goodColors_: goodColors, goodPlaces_: goodPlaces, wins_: wins, looses_: looses, timer_: timer, actualLevel_: actualLevel, actualCell_: actualCell)
    }
    
    // Used to implement Codable by creating a game with the information of a previous game
    init(gamingMode_: gameMode, gamingState_: gameState, board_: [color], solution_: [color], goodColors_: [Int], goodPlaces_: [Int], wins_: Int, looses_: Int, timer_: Int, actualLevel_: Int, actualCell_: Int) {
        self.gamingMode = gamingMode_
        self.gamingState = gamingState_
        self.board = board_
        self.solution = solution_
        self.goodColors = goodColors_
        self.goodPlaces = goodPlaces_
        self.wins = wins_
        self.looses = looses_
        self.timer = timer_
        self.actualLevel = actualLevel_
        self.actualCell = actualCell_
    }
}

// Enumerate the different game mode
enum gameMode: String, Codable {
    case TRAINING, PRO
}

// Enumerate the different color in the game
enum color: UInt32, Codable {
    case PURPLE, PINK, YELLOW, GREEN, BLUE, RED, GREY
    
    private static let _count: color.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = color(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    // Function used select a random color except grey
    static func randomColorExceptGrey() -> color {
        
        // pick and return a new value exept grey
        var aColor: color
        repeat {
            let rand = arc4random_uniform(_count)
            aColor = color(rawValue: rand)!
        } while aColor == color.GREY
        return aColor
    }
}

// Enumerate the different game state
enum gameState: String, Codable {
    case UNFINISHED, WON, LOST
}
