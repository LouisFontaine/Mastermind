//
//  SettingViewController.swift
//  Mastermind
//
//  Created by Louis Fontaine on 13/03/2019.
//  Copyright © 2019 Louis Fontaine. All rights reserved.
//

import UIKit

var game = MasterMind(newGamingMode: gameMode.TRAINING, wins: 0, looses: 0) // Store the actual game
var games = [MasterMind]() // Store all the previous games

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var WinsLabel: UILabel!
    @IBOutlet weak var FailsLabel: UILabel!
    @IBOutlet weak var GameModeSegmentedControl: UISegmentedControl!
    
    // Fuction used when the user press "Play" button
    @IBAction func pressPlayButton(_ sender: UIButton) {
        
        //  If the user select "Training" Mode
        if(GameModeSegmentedControl.selectedSegmentIndex == 0) {
            // Start a new game on the model
            if (games.count != 0) {
                game = MasterMind(newGamingMode: gameMode.TRAINING, wins: games[games.count - 1].wins , looses: games[games.count - 1].looses)
            }
            else {
                game = MasterMind(newGamingMode: gameMode.PRO, wins: 0, looses: 0)
            }
        }
            
        //  If the user select "Training" Mode
        else if(GameModeSegmentedControl.selectedSegmentIndex == 1)
        {
            // Start a new game on the model
            if (games.count != 0) {
                game = MasterMind(newGamingMode: gameMode.PRO, wins: games[games.count - 1].wins , looses: games[games.count - 1].looses)
            }
            else {
                game = MasterMind(newGamingMode: gameMode.PRO, wins: 0, looses: 0)
            }
            
        }
        self.performSegue(withIdentifier: "goToTheGameSegue", sender: self)
    }
    
    // Fuction used when the user press the "Reset Statistics" button
    @IBAction func pressResetStatisticsButton(_ sender: UIButton) {
        // Reset the wins and loose var in the actual game
        game.resetWinsLooses()
        
        // Reset historic of games
        games = [MasterMind]()
        
        // Remove all games stored in UserDefaults
        UserDefaults.standard.removeObject(forKey: "myGames")
        
        // Update view from model
        updateView()
    }
    
    // Fucnction used to update the view depending of the model
    func updateView() {
        if games.count != 0 {
            self.WinsLabel.text = String(games[games.count - 1].wins)
            self.FailsLabel.text = String(games[games.count - 1].looses)
        }
        else {
            self.WinsLabel.text = "0"
            self.FailsLabel.text = "0"
        }
        self.TableView.reloadData()
    }
    
    // Fuction used when the view is launched
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            if games.count == 0 && game.gamingState == gameState.UNFINISHED {
                // print("Load data from file")
                    // Load encoded data from UserDefaults
                    let data = UserDefaults.standard.data(forKey: "myGames")
                
                    // Decode data
                    let jsonDecoder = JSONDecoder()
                    if data != nil {
                        games = try jsonDecoder.decode(Array<MasterMind>.self, from: data!)
                    }
            }
            else if game.gamingState != gameState.UNFINISHED {
                // print("Add the game to games and save data in file")
                games.append(game)
            
                // Encode game array
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(games)
                
                // Save encoded data to UserDefaults
                UserDefaults.standard.set(jsonData, forKey: "myGames")
            }
        }
        catch {
            print(error)
        }
        
        // Update view from model
        updateView()
    }
    
    // Used to configure UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    // Used to configure UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var text = String(games[indexPath.row].gamingState.rawValue)
        text.append(" - Mode : ")
        text.append(String(Substring(games[indexPath.row].gamingMode.rawValue)))
        text.append(" - Attempt : ")
        text.append(String(games[indexPath.row].actualLevel))
        cell.textLabel?.text = text
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
