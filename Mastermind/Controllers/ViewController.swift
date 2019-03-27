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
    
    // Function used when a user press a color to fill a line
    @IBAction func pressColorButton(_ sender: UIButton) {
        game.setCellColor(buttonColor: sender.accessibilityLabel!)
        updateViewFromModel()
    }
    
    // Function used when a user "erase" button to erase a color in the line
    @IBAction func pressEraseButton(_ sender: UIButton) {
        game.erase()
        updateViewFromModel()
    }
    
    /* Function used when "evaluate" button to evaluate a line, show how
    many good color and places there are on a line */
    @IBAction func pressEvaluateButton(_ sender: UIButton) {
        var message: String
        
        // Use model function to evaluate the line
        game.evaluate()
        
        // Updtate de view
        updateViewFromModel()
        
        // if the game is finished
        if game.gamingState == gameState.WON || game.gamingState == gameState.LOST {
            if game.gamingState == gameState.WON { message = "You won the game !" }
            else { message =  "You loose the game" }
            
            // invalidate the timer if game is in Pro mode
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            
            // Alert the user either if he won or loose the game and redirect to setting view
            let alert = UIAlertController(title: "Game finished", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)}))
            self.present(alert, animated: true)
        }
    }
    
    // Function used if the user press 'Settings" button
    @IBAction func pressSettingButton(_ sender: UIButton) {
        
        // Alert the user that he will loose the game if he goes to setting view
        let refreshAlert = UIAlertController(title: "Go to Setting", message: "You will loose the current game", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in game.addALoose(); self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)}))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in}))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    // Function used to update the view depending on model
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
    
    // Fuction used by updateViewFromModel() to return an image depending of the location on the board
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
    
    // Function used when the view is launched
    override func viewDidLoad() {
        super.viewDidLoad()
        // If game mode is Pro when the game start, we need to start a timer
        if game.gamingMode == gameMode.PRO {
            myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(clock_1), userInfo: nil, repeats: true)
        }
        updateViewFromModel()
    }
    
    // Fuction used by the timer to decremente the tiler
    @objc func clock_1() {
        //decrease timer on model
        game.decreaseTimer()
        
        // Update the view with the changes
        updateViewFromModel()
        
        // Check game state of the model
        // if the game is finished
        if game.gamingState == gameState.WON || game.gamingState == gameState.LOST {
            var message: String
            // invalidate timer
            self.myTimer?.invalidate()
            
            if game.gamingState == gameState.WON { message = "You won the game !" }
            else { message =  "You loose the game" }
            
            // invalidate the timer if game is in Pro mode
            if game.gamingMode == gameMode.PRO {
                self.myTimer?.invalidate()
            }
            
            // Alert the user either if he won or loose the game and redirect to setting view
            let alert = UIAlertController(title: "Game finished", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to game settings", style: .default, handler: {
                action in self.performSegue(withIdentifier: "goToSettingPageSegue", sender: self)}))
            self.present(alert, animated: true)
        }
    }
}
