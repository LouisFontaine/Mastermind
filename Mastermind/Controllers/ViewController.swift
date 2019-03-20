//
//  ViewController.swift
//  Mastermind
//
//  Created by Louis Fontaine on 13/03/2019.
//  Copyright © 2019 Louis Fontaine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var WinsLabel: UILabel!
    @IBOutlet weak var FailsLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var TimerTextLabel: UILabel!
    @IBOutlet var Cells: [UIImageView]!
    @IBOutlet var ColorsLabels: [UILabel]!
    @IBOutlet var PlacesLabels: [UILabel]!
    private var myTimer: Timer?
    
    @IBAction func pressColorButton(_ sender: UIButton) {
        game.setCellColor(buttonColor: sender.accessibilityLabel!)
        updateViewFromModel()
    }
    
    @IBAction func pressEraseButton(_ sender: UIButton) {
        game.erase()
        updateViewFromModel()
    }
    
    @IBAction func pressEvaluateButton(_ sender: UIButton) {
        game.evaluate()
        updateViewFromModel()
        
        // If the game is won
        if game.gamingState == gameState.WON {
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            let alert = UIAlertController(title: "Game finished", message: "You won the game !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)
            }))
            self.present(alert, animated: true)
        }
            
        // Else, if the game is lost
        else if game.gamingState == gameState.LOST {
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            let alert = UIAlertController(title: "Game finished", message: "You lost the game !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)
            }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func pressSettingButton(_ sender: UIButton) {
        
        //////////
        //let GameManagere = GameManager()
        //GameManagere.saveGameManager()
        /////////
        
        let refreshAlert = UIAlertController(title: "Go to Setting", message: "You will loose the current game", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            game.addALoose()
            self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    func updateViewFromModel() {
        WinsLabel.text = String(game.wins)
        FailsLabel.text = String(game.looses)
        TimerLabel.text = String(game.timer)
        
        if game.gamingMode == gameMode.PRO {
            TimerLabel.isHidden = false
            TimerTextLabel.isHidden = false
        }
        else {
            TimerLabel.isHidden = true
            TimerTextLabel.isHidden = true
        }
        
        for UIImageView in Cells {
            UIImageView.image = returnImageCellFromModel(Label: Int(UIImageView.accessibilityLabel!)!)
        }
        for UILabel in ColorsLabels {
            UILabel.text = String(game.goodColors[Int(UILabel.accessibilityLabel!)!])
        }
        for UILabel in PlacesLabels {
            UILabel.text = String(game.goodPlaces[Int(UILabel.accessibilityLabel!)!])
        }
    }
    
    func returnImageCellFromModel(Label: Int) -> UIImage {
        if game.board[Label] == color.PURPLE {
            return UIImage(named: "buttonPurple.png")!
        }
        else if game.board[Label] == color.PINK {
            return UIImage(named: "buttonPink.png")!
        }
        else if game.board[Label] == color.YELLOW {
            return UIImage(named: "buttonYellow.png")!
        }
        else if game.board[Label] == color.GREEN {
            return UIImage(named: "buttonGreen.png")!
        }
        else if game.board[Label] == color.BLUE {
            return UIImage(named: "buttonBlue.png")!
        }
        else if game.board[Label] == color.RED {
            return UIImage(named: "buttonRed.png")!
        }
        else {
            return UIImage(named: "buttonGrey.png")!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If game mode is Pro when the game start, we need to start a timer
        if game.gamingMode == gameMode.PRO {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(clock_1), userInfo: nil, repeats: true)
        }
        updateViewFromModel()
    }
    
    @objc func clock_1() {
        game.decreaseTimer()
        updateViewFromModel()
        
        // If the game is won
        if game.gamingState == gameState.WON {
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            let alert = UIAlertController(title: "Game finished", message: "You won the game !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)
            }))
            self.present(alert, animated: true)
        }
            
        // Else, if the game is lost
        else if game.gamingState == gameState.LOST {
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            let alert = UIAlertController(title: "Game finished", message: "You lost the game !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)
            }))
            self.present(alert, animated: true)
        }
    }
}

