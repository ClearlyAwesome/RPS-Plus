//
//  GameOverViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 1/2/21.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var gameStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStatus.text = "You \(GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue.capitalized)!"
        
        playAgain.layer.cornerRadius = 25
        
    }
    

}
