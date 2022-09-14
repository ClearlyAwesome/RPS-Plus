//
//  StartViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 12/19/20.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var threeRounds: UIButton!
    @IBOutlet weak var startGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame.layer.cornerRadius = 25
        threeRounds.layer.cornerRadius = 25
      
    }
    
    @IBAction func threeRounds(_ sender: UIButton) {
        global.gameMode = "rounds"
    }
    @IBAction func unlimited(_ sender: UIButton) {
        global.gameMode = "unlimited"
    }
    
}
