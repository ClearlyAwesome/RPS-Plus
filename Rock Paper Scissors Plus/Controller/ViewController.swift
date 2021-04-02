//
//  ViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 10/11/20.
//
import UIKit
import AVFoundation

class Global {
    var weaponA = String()
    var weaponB = String()
    var weaponC = String()
    var weaponOne = UIButton()
    var weaponTwo = UIButton()
    var weaponThree = UIButton()
    var userSign: String?
    var opponentSign: String?
    var shooter = UIButton()
    
}
let global = Global()

class ViewController: UIViewController {
    //MARK: - Basic Variables and setup
    //These will be score labels.
    var opponentScore = 0
    var userScore = 0
    
    var battle = GameState.battle(GameState.init())
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 3.0
    var secondsPassed = 0.0
    
    @IBOutlet weak var opponentChoice: UIImageView!
    @IBOutlet weak var userChoice: UIImageView!
    @IBOutlet weak var armoryButton: UIButton!
    
    @IBOutlet weak var whoWon: UILabel!
    @IBOutlet weak var weaponOne: UIButton!
    @IBOutlet weak var weaponTwo: UIButton!
    @IBOutlet weak var weaponThree: UIButton!
    //  @IBOutlet weak var youChose: UILabel!
    @IBOutlet weak var shootButton: UIButton!
    
    //Score Buttons
    @IBOutlet weak var OpponentScoreThree: UIImageView!
    @IBOutlet weak var OpponentScoreTwo: UIImageView!
    @IBOutlet weak var OpponentScoreOne: UIImageView!
    @IBOutlet weak var UserScoreThree: UIImageView!
    @IBOutlet weak var UserScoreTwo: UIImageView!
    @IBOutlet weak var UserScoreOne: UIImageView!
    
    
    //These are the choices to choose from
    var choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot"]
    
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        global.weaponOne = weaponOne
        global.weaponTwo = weaponTwo
        global.weaponThree = weaponThree
        global.shooter = shootButton
        
        weaponOne.setImage(UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: "rock")!)))), for: .normal)
        weaponTwo.setImage(UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: "paper")!)))), for: .normal)
        weaponThree.setImage(UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: "scissors")!)))), for: .normal)
        
        //youChose.text = "Ready to play?"
        armoryButton.layer.cornerRadius = 15
        shootButton.layer.cornerRadius = 15
        globalTwo.weaponA = "rock"
        globalTwo.weaponB = "paper"
        globalTwo.weaponC = "scissors"
        weaponOne.setTitle(globalTwo.weaponA, for: .normal)
        weaponTwo.setTitle(globalTwo.weaponB, for: .normal)
        weaponThree.setTitle(globalTwo.weaponC, for: .normal)
        timer.invalidate()
        secondsPassed = 0.0
        totalTime = 10.0
        shootButton.isEnabled = false
        
        
        
    }
    //MARK: - Armory Button
    @IBAction func armory(_ sender: UIButton) {
        performSegue(withIdentifier: "goToArmory", sender: self)
        
    }
    
    
    //MARK: - Ready Shoot!
    //This button acts as a "Ready, Shoot" button.
    @IBAction func shoot(_ sender: UIButton) {
        update()
        //This plays music for each second.
        let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        timer.invalidate()
        //This resets my timer
        totalTime = 3.0
        //This makes sure that the first/starting name is the name of weaponOne's title.
        whoWon.text = String(global.weaponOne.currentTitle?.capitalized ?? "Rock")
        sender.isEnabled = false
        //This starts my timer
        timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        //This hides all icons.
        userChoice.isHidden = true
        opponentChoice.isHidden = true
        //  youChose.isHidden = false
        whoWon.isHidden = false
        weaponOne.isHidden = true
        weaponTwo.isHidden = true
        weaponThree.isHidden = true
        armoryButton.isHidden = true
        UserScoreOne.isHidden = true
        UserScoreTwo.isHidden = true
        UserScoreThree.isHidden = true
        OpponentScoreOne.isHidden = true
        OpponentScoreTwo.isHidden = true
        OpponentScoreThree.isHidden = true
        //  youChose.text = "Good luck!"
        //This is my delay. So that I can get "Rock, Paper, Scissors, Shoot" out on the screen.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.changePicture()
            self.timer.invalidate()
            self.playSounds()
            self.whoWon.text = "You \(GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue.capitalized)!"
            self.scoreCount()
//            sender.isEnabled = true
        }
        
        //        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTimer), userInfo: nil, repeats: true)
    }
    //MARK: - Choose your weapon!
    //This will be my CHOOSE YOUR WEAPON function
    @IBAction func chooseWeapon(_ sender: UIButton) {
        shootButton.isEnabled = true
        
        sender.flash()
        global.userSign = sender.currentTitle!
        print(global.userSign!)
        
        
//        if sender.tag == 1 {
//            print(sender.currentTitle!)
//            sender.layer.borderWidth = 0.0
//            sender.layer.cornerRadius = 0.0
//            sender.layer.borderWidth = 2.0
//            sender.layer.cornerRadius = 40.0
//        } else if sender.tag == 2 {
//            sender.layer.borderWidth = 2.0
//            sender.layer.cornerRadius = 40.0
//            //  sender.isSelected = false
//        } else if sender.tag == 3 {
//            sender.layer.borderWidth = 0.0
//            sender.layer.cornerRadius = 0.0
//            sender.layer.borderWidth = 2.0
//            sender.layer.cornerRadius = 40.0
//        }
    }
    

    
    //MARK: - Game Sounds
    func playSounds() -> GameState {
        //I wanted this here to play certain sounds if the player loses/wins/draws.
        if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .win {
            userScore += 1
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
            //            print(opponentScore)
            let secondUrl = Bundle.main.url(forResource: "lose", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        }
        return GameState()
    }
    //MARK: - Update Timer and more noises
    @objc func update() {
        //All this does is update the timer and flash the weapon titles on the screen.
        if totalTime > 0 {
            totalTime -= 1
        }
        if totalTime == 3 {
            whoWon.text = String(global.weaponOne.currentTitle!.capitalized)
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 2 {
            whoWon.text = String(global.weaponTwo.currentTitle!.capitalized)
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 1 {
            whoWon.text = String(global.weaponThree.currentTitle!.capitalized)
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
        if userScore == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                UserScoreOne.image = UIImage(systemName: "circle.fill")
            }
        } else if userScore == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                UserScoreTwo.image = UIImage(systemName: "circle.fill")
            }
        } else if userScore == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                UserScoreThree.image = UIImage(systemName: "circle.fill")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.gameOver()
                }
            }
        }
        if opponentScore == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                OpponentScoreOne.image = UIImage(systemName: "circle.fill")
            }
        } else if opponentScore == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                OpponentScoreTwo.image = UIImage(systemName: "circle.fill")
            }
        } else if opponentScore == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [self] in
                OpponentScoreThree.image = UIImage(systemName: "circle.fill")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.gameOver()
                }
            }
        }
    }
    
    func gameOver() {
        performSegue(withIdentifier: "gameOver", sender: self)
    }
    
    
    //MARK: - Meat and potatoes
    func changePicture() -> GameState {
        //This activates all my icons back.
        userChoice.isHidden = false
        opponentChoice.isHidden = false
        whoWon.isHidden = false
        // youChose.isHidden = false
        weaponOne.isHidden = false
        weaponTwo.isHidden = false
        weaponThree.isHidden = false
        armoryButton.isHidden = false
        UserScoreOne.isHidden = false
        UserScoreTwo.isHidden = false
        UserScoreThree.isHidden = false
        OpponentScoreOne.isHidden = false
        OpponentScoreTwo.isHidden = false
        OpponentScoreThree.isHidden = false
        choices.removeAll()
        weaponOne.setTitle(globalTwo.weaponA, for: .normal)
        weaponTwo.setTitle(globalTwo.weaponB, for: .normal)
        weaponThree.setTitle(globalTwo.weaponC, for: .normal)
        choices += [weaponOne.currentTitle!, weaponTwo.currentTitle!, weaponThree.currentTitle!]
        
        
        //Assigning a random element to the players. This will eventually be a different formula.
//        global.userSign = GameState.Sign.init(rawValue: choices.randomElement()!).map { $0.rawValue }
        global.opponentSign = GameState.Sign.init(rawValue: choices.randomElement()!).map { $0.rawValue }
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
//MARK: - UIImage Extension
extension UIImage {
    enum AssetIdentifier: String {
        case rock = "rock"
        case paper = "paper"
        case scissors = "scissors"
        case meteor = "meteor"
        case dynamite = "dynamite"
        case nuclearBomb = "nuclearBomb"
        case cockroach = "cockroach"
        case car = "car"
        case dinosaur = "dinosaur"
        case boot = "boot"
        
        static let choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot"]
        
    }
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
//MARK: - UIButton Extension
extension UIButton {
    func flash() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.3
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 2
    layer.add(flash, forKey: nil)
    }
    
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.98
    pulse.toValue = 1.0
    pulse.autoreverses = true
    pulse.repeatCount = .infinity
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    layer.add(pulse, forKey: nil)
    }
}
