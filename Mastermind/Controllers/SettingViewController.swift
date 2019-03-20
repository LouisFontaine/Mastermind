//
//  SettingViewController.swift
//  Mastermind
//
//  Created by Louis Fontaine on 13/03/2019.
//  Copyright © 2019 Louis Fontaine. All rights reserved.
//

import UIKit

var game = MasterMindModel()

class SettingViewController: UIViewController {
    
    @IBOutlet weak var WinsLabel: UILabel!
    @IBOutlet weak var FailsLabel: UILabel!
    @IBOutlet weak var GameModeSegmentedControl: UISegmentedControl!
    
    @IBAction func pressPlayButton(_ sender: UIButton) {
        if(GameModeSegmentedControl.selectedSegmentIndex == 0)
        {
            game.resetGame(newGamingMode: gameMode.TRAINING)
            
        }
        else if(GameModeSegmentedControl.selectedSegmentIndex == 1)
        {
            game.resetGame(newGamingMode: gameMode.PRO)
        }
        self.performSegue(withIdentifier: "goToTheGameSegue", sender: self)
    }
    
    @IBAction func pressResetStatisticsButton(_ sender: UIButton) {
        game.resetWinsLooses()
        self.WinsLabel.text = "0"
        self.FailsLabel.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WinsLabel.text = String(game.wins)
        self.FailsLabel.text = String(game.looses)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
