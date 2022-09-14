//
//  ChooseWeapons.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 7/2/22.
//

import UIKit

class ChooseWeapons: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    var weaponArray = [String]()
    var opponentsWeapons = [String]()
    var choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot"]
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .dark
        navigationController?.overrideUserInterfaceStyle = .dark
        submitButton.isEnabled = false
    }
    
    @IBAction func chooseWeapons(_ sender: UIButton) {
        
        switch sender.isTouchInside && sender.layer.borderWidth == 4.0 {
        case true:
            sender.layer.borderWidth = 0.0
            count -= 1
            weaponArray.removeLast()
        case false:
            sender.layer.borderWidth = 4.0
            sender.layer.cornerRadius = 25.0
            count += 1
            weaponArray.append((sender.titleLabel?.text)!)
        }
        switch count {
        case 0:
            submitButton.isEnabled = false
        case 1:
            submitButton.isEnabled = false
        case 2:
            submitButton.isEnabled = false
        case 3:
            submitButton.isEnabled = true
            globalTwo.weaponA = weaponArray[0]
            globalTwo.weaponB = weaponArray[1]
            globalTwo.weaponC = weaponArray[2]
        case 4:
            self.showMyAlert()
            sender.layer.borderWidth = 0.0
            count -= 1
            weaponArray.removeLast()
            submitButton.isEnabled = true
        default:
            sender.isEnabled = true
        }
    }
    //MARK: - Submit Functionality
    @IBAction func submit(_ sender: UIButton) {
        if count < 3 {
            sender.isEnabled = false
        } else {
            globalTwo.weaponA = weaponArray[0]
            globalTwo.weaponB = weaponArray[1]
            globalTwo.weaponC = weaponArray[2]
        }
        //Setting the image of the weapons on the home screen.
        global.weaponOne.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((weaponArray[0] ))))!), for: .normal)
        global.weaponTwo.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((weaponArray[1] ))))!), for: .normal)
        global.weaponThree.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((weaponArray[2] ))))!), for: .normal)
        
        //Setting the button's title on home screen.
        global.weaponOne.setTitle(weaponArray[0], for: .normal)
        global.weaponTwo.setTitle(weaponArray[1], for: .normal)
        global.weaponThree.setTitle(weaponArray[2], for: .normal)
        global.shooter.isEnabled = false
    }
}
