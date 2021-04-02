//
//  StartViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 12/19/20.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame.layer.cornerRadius = 25
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
