//
//  ViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 10/11/20.
//
import UIKit
import AVFoundation
import GoogleMobileAds

//Global Class #1
class Global {
    var weaponA = String()
    var weaponB = String()
    var weaponC = String()
    var weaponOne = UIButton()
    var weaponTwo = UIButton()
    var weaponThree = UIButton()
    var userSign: String?
    var opponentSign: String?
    var opponentSignA = UIButton()
    var opponentSignB = UIButton()
    var opponentSignC = UIButton()
    var opponentweaponA = String()
    var opponentweaponB = String()
    var opponentweaponC = String()
    var shooter = UIButton()
    var adPrepCount = 0
    var adViewHeight = NSLayoutConstraint()
    var webString = String()
    var gameMode = String()
    
}
let global = Global()

//Global Class #2
class GlobalTwo {
    var weaponA: String?
    var weaponB: String?
    var weaponC: String?
}
let globalTwo = GlobalTwo()

class GamePlayViewController: UIViewController {
    //MARK: - Basic Variables and setup
    //These will be score labels.
    var opponentScore = 0
    var userScore = 0
    var battle = GameState.battle(GameState.init())
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 3.0
    var secondsPassed = 0.0
    var round = 1
    //These are the choices to choose from
    var choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot"]
    var opponentsWeapons = [String]()
    var uniqueOpponent = Set<String>()
    
    //Ad Variables
    var oBannerView: GADBannerView!
    var oInterstitial: GADInterstitialAd!
    let request = GADRequest()
    
    //IBOutlets
    @IBOutlet weak var opponentChoice: UIImageView!
    @IBOutlet weak var userChoice: UIImageView!
    @IBOutlet weak var gameScore: UILabel!
    @IBOutlet weak var whoWon: UILabel!
    @IBOutlet weak var weaponOne: UIButton!
    @IBOutlet weak var weaponTwo: UIButton!
    @IBOutlet weak var weaponThree: UIButton!
    @IBOutlet weak var opponentWeaponOne: UIButton!
    @IBOutlet weak var opponentWeaponTwo: UIButton!
    @IBOutlet weak var opponentWeaponThree: UIButton!
    @IBOutlet weak var shootButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Choosing game mode
//        switch global.gameMode {
//        case "unlimited":
//            gameScore.text = String("\(opponentScore)-\(userScore)")
//        case "rounds":
//            gameScore.text = String("\(opponentScore)-\(userScore)")
//        default:
//            print("something is wrong")
//        }
        
        //Initial set up of variables and their state
        gameScore.text = String("\(opponentScore)-\(userScore)")
        global.weaponOne = weaponOne
        global.weaponTwo = weaponTwo
        global.weaponThree = weaponThree
        global.shooter = shootButton
        global.opponentSignA = opponentWeaponOne
        global.opponentSignB = opponentWeaponTwo
        global.opponentSignC = opponentWeaponThree
        shootButton.isEnabled = false
        global.shooter.isEnabled = false
        shootButton.layer.cornerRadius = 15
        chooseOpponentWeapons()
        timer.invalidate()
        secondsPassed = 0.0
        totalTime = 10.0
    }
    
    //MARK: - Home Screen Button
    @IBAction func home(_ sender: UIButton) {
        let alert = UIAlertController(title: "Quit?", message: "Are you sure you want to quit and go back to the home screen?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (ACTION) in
            //do action here
            self.showStartScreen()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showSettings(_ sender: UIButton) {
        showSettings()
    }
    
    //MARK: - Ready Shoot!
    //This button acts as a "Ready, Shoot" button.
    @IBAction func shoot(_ sender: UIButton) {
        //This prevents multiple taps of "shoot"
        sender.isEnabled = false
        update()
        round += 1
        
        //This plays music for each second.
        let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        timer.invalidate()
        
        //This resets my timer
        totalTime = 3.0
        
        //This makes sure that the first/starting name is the name of weaponOne's title.
        //I changed this to just be "1" and for it to count up to "3"
        whoWon.text = "1"
        
        //This starts my timer
        timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        //This hides all icons.
        whoWon.isHidden = false
        gameScore.isHidden = true
        userChoice.isHidden = true
        opponentChoice.isHidden = true
        weaponOne.isHidden = true
        weaponTwo.isHidden = true
        weaponThree.isHidden = true
        shootButton.isHidden = true
        opponentWeaponOne.isHidden = true
        opponentWeaponTwo.isHidden = true
        opponentWeaponThree.isHidden = true
        homeButton.isHidden = true
        settingsButton.isHidden = true
        
        //This is my delay. So that I can get "1, 2, 3, Shoot" out on the screen.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.changePicture()
            self.timer.invalidate()
            self.playSounds()
            self.whoWon.text = "You \(GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue.capitalized)!"
            self.scoreCount()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.whoWon.text = "Round \(self.round)"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.whoWon.text = "Choose your weapon to begin"
                    //This prevents multiple taps of "shoot"
                    sender.isEnabled = false
                }
            }
        }
    }
    //MARK: - Choose your weapon!
    //This will be my CHOOSE YOUR WEAPON function
    @IBAction func chooseWeapon(_ sender: UIButton) {
        if whoWon.text == "Choose your weapon to begin" {
            shootButton.isEnabled = true
            sender.flash()
            global.userSign = sender.currentTitle!
        }
    }
    
    func chooseOpponentWeapons() {
        uniqueOpponent = Set(choices)
        choices.shuffle()
        global.opponentweaponA = choices[0]
        global.opponentweaponB = choices[1]
        global.opponentweaponC = choices[2]
        choices.remove(at: 0)
        choices.remove(at: 1)
        choices.remove(at: 2)
        opponentsWeapons += [global.opponentweaponA, global.opponentweaponB, global.opponentweaponC]
        //Setting the opponent's choices.
        global.opponentSignA.setTitle(global.opponentweaponA, for: .normal)
        global.opponentSignB.setTitle(global.opponentweaponB, for: .normal)
        global.opponentSignC.setTitle(global.opponentweaponC, for: .normal)
        
        //Setting the image of the weapons on the home screen.
        global.opponentSignA.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((global.opponentweaponA ))))!), for: .normal)
        global.opponentSignB.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((global.opponentweaponB ))))!), for: .normal)
        global.opponentSignC.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((global.opponentweaponC ))))!), for: .normal)
        
        
    }
    
    //MARK: - Game Sounds
    func playSounds() -> GameState {
        //I wanted this here to play certain sounds if the player loses/wins/draws.
        if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .win {
            userScore += 1
            //            userScoreLabel.text = String(userScore)
            //            print(userScore)
            let secondUrl = Bundle.main.url(forResource: "final Ding", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        } else  if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .draw {
            //            print(userScore)
            let secondUrl = Bundle.main.url(forResource: "gasp", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        } else  if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .lose {
            opponentScore += 1
            //            opponentScoreLabel.text = String(opponentScore)
            //            print(opponentScore)
            let secondUrl = Bundle.main.url(forResource: "lose", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        }
        return GameState()
    }
    
    //MARK: - Update Timer and more noises
    @objc func update() {
        whoWon.font = UIFont(name: "Chalkduster", size: 65.0)
        //All this does is update the timer and flash the count on the screen.
        if totalTime > 0 {
            totalTime -= 1
        }
        if totalTime == 3 {
            whoWon.text = "1"
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 2 {
            whoWon.text = "2"
            //            whoWon.text = String(global.weaponTwo.currentTitle!.capitalized)
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 1 {
            whoWon.text = "3"
            //            whoWon.text = String(global.weaponThree.currentTitle!.capitalized)
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 0 {
            whoWon.text = "Shoot"
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    func scoreCount() {
        switch global.gameMode {
        case "unlimited":
            switch GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue {
            case "win":
                print("win")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            case "lose":
                print("lose")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            case "draw":
                print("draw")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            default:
                print("default")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            }
            
        case "rounds":
            switch GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue {
            case "win":
                print("win")
                gameScore.text = String("\(opponentScore)-\(userScore)")
                if userScore == 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.gameOver()
                    }
                }
            case "lose":
                print("lose")
                gameScore.text = String("\(opponentScore)-\(userScore)")
                if opponentScore == 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.gameOver()
                    }
                }
            case "draw":
                print("draw")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            default:
                print("default")
                gameScore.text = String("\(opponentScore)-\(userScore)")
            }
        default:
            print("ruh-roh")
        }
    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameOver", sender: self)
    }
    
    
    //MARK: - Meat and potatoes
    func changePicture() -> GameState {
        //This activates all my icons back.
        whoWon.font = UIFont(name: "Chalkduster", size: 19.0)
        userChoice.isHidden = false
        opponentChoice.isHidden = false
        shootButton.isHidden = false
        whoWon.isHidden = false
        gameScore.isHidden = false
        weaponOne.isHidden = false
        weaponTwo.isHidden = false
        weaponThree.isHidden = false
        opponentWeaponOne.isHidden = false
        opponentWeaponTwo.isHidden = false
        opponentWeaponThree.isHidden = false
        homeButton.isHidden = false
        settingsButton.isHidden = false
        switch global.gameMode {
        case "unlimited":
            gameScore.isHidden = false
            
        case "rounds":
            print("hey")
            gameScore.isHidden = false
            
        default:
            print("something is wrong")
        }
        //        choices.removeAll()
//        weaponOne.setTitle(globalTwo.weaponA, for: .normal)
//        weaponTwo.setTitle(globalTwo.weaponB, for: .normal)
//        weaponThree.setTitle(globalTwo.weaponC, for: .normal)
        choices += [weaponOne.currentTitle!, weaponTwo.currentTitle!, weaponThree.currentTitle!]
        
        
        //Assigning a random element to the players. This will eventually be a different formula.
        //        global.userSign = GameState.Sign.init(rawValue: choices.randomElement()!).map { $0.rawValue }
        //MARK: - opponent's sign
        
        global.opponentSign = opponentsWeapons.randomElement()
        
        //        GameState.Sign.init(rawValue: opponentsWeapons.randomElement()!).map { $0.rawValue }
        print(global.opponentSign)
        print(opponentWeaponOne.currentTitle)
        //        print(userSign!)
        //        print(opponentSign!)
        //Changing the label on the bottom. This will probably be deleted.
        //   youChose.text = " You chose, \(userSign!)!"
        //Changing the images to the current sign
        opponentChoice.image = UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: global.opponentSign!)!))))
        userChoice.image = UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: global.userSign!)!))))
        return GameState()
    }
}

