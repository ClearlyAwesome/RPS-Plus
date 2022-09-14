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
    var  choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot", "katana"]
    var myView = UIView(frame: CGRect(x: -20, y: -20, width: 150, height: 300))
    var myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var rowString = String()
    
    
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
    @IBOutlet weak var whoWon: UILabel!
    @IBOutlet weak var shootButton: UIButton!
    
    //Score Buttons as bubbles
    @IBOutlet weak var OpponentScoreThree: UIImageView!
    @IBOutlet weak var OpponentScoreTwo: UIImageView!
    @IBOutlet weak var OpponentScoreOne: UIImageView!
    @IBOutlet weak var UserScoreThree: UIImageView!
    @IBOutlet weak var UserScoreTwo: UIImageView!
    @IBOutlet weak var UserScoreOne: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        global.userSign = "rock"
        shootButton.layer.cornerRadius = 15
        timer.invalidate()
        secondsPassed = 0.0
        totalTime = 10.0
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
        whoWon.text = "3"
        sender.isEnabled = false
        //This starts my timer
        timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        //This hides all icons.
        userChoice.isHidden = true
        opponentChoice.isHidden = true
        //  youChose.isHidden = false
        whoWon.isHidden = false
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
            sender.isEnabled = true
        }
    }
    
    //MARK: - Game Sounds
    func playSounds() -> GameState {
        //I wanted this here to play certain sounds if the player loses/wins/draws.
        if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .win {
            userScore += 1
            
            let secondUrl = Bundle.main.url(forResource: "final Ding", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        } else  if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .draw {
            let secondUrl = Bundle.main.url(forResource: "gasp", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        } else  if GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!) == .lose {
            opponentScore += 1
            let secondUrl = Bundle.main.url(forResource: "lose", withExtension: "wav")
            self.player = try! AVAudioPlayer(contentsOf: secondUrl!)
            self.player.play()
        }
        return GameState()
    }
    //    //MARK: -IF/ELSE Statement
    //    func numberToTextA () {
    //        //Picker One IF/ELSE Statement
    //        if chooseWeapon.selectedRow(inComponent: 0) == 0 {
    //            global.userSign = "rock"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 1 {
    //            global.userSign = "paper"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 2 {
    //            global.userSign = "scissors"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 3 {
    //            global.userSign = "meteor"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 4 {
    //            global.userSign = "dynamite"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 5 {
    //            global.userSign = "nuclearBomb"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 6 {
    //            global.userSign = "cockroach"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 7 {
    //            global.userSign = "car"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 8 {
    //            global.userSign = "dinosaur"
    //        } else if chooseWeapon.selectedRow(inComponent: 0) == 9 {
    //            global.userSign = "boot"
    //        }    else {
    //            global.userSign = "rock"
    //        }
    //    }
    
    //MARK: - Update Timer and more noises
    @objc func update() {
        //All this does is update the timer and flash the weapon titles on the screen.
        if totalTime > 0 {
            totalTime -= 1
        }
        if totalTime == 3 {
            whoWon.text = "3"
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 2 {
            whoWon.text = "2"
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        } else if totalTime == 1 {
            whoWon.text = "1"
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
        //        numberToTextA()
        //This activates all my icons back.
        userChoice.isHidden = false
        opponentChoice.isHidden = false
        whoWon.isHidden = false
        // youChose.isHidden = false
        UserScoreOne.isHidden = false
        UserScoreTwo.isHidden = false
        UserScoreThree.isHidden = false
        OpponentScoreOne.isHidden = false
        OpponentScoreTwo.isHidden = false
        OpponentScoreThree.isHidden = false
        
        
        //Assigning a random element to the players. This will eventually be a different formula.
        global.userSign = GameState.Sign.init(rawValue: global.choices.randomElement()!).map { $0.rawValue }
        global.opponentSign = GameState.Sign.init(rawValue: global.choices.randomElement()!).map { $0.rawValue }
        
        //Changing the images to the current sign
        opponentChoice.image = UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: global.opponentSign!)!))))
        userChoice.image = UIImage.init(assetIdentifier: (((UIImage.AssetIdentifier(rawValue: global.userSign!)!))))
        print(global.opponentSign!)
        print(global.userSign!)
        print(GameState.init().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!))
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
        case katana = "katana"
        
        static let choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot", "katana"]
        
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
//extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    //MARK: -PickerView Stuff
//    //Functionality of the app's pickerView
//    //This indicates how many columns
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    //This indicates how many rows. Use a .count function here.
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return choices.count
//    }
//    //This indicates the title for the row. Use some sort of GET like below.
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return choices[row]
//    }
//    //This indicates that a selection was made
//    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String {
//        return rowString
//    }
//    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 150
//    }
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return -300.0
//
//    }
//MARK: -UIPickerViewDelegate

//func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//
//    global.myView = UIView(frame: CGRect(x: -20, y: -20, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height))
//    global.myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//
//    switch row {
//        case 0:
//            global.rowString = "rock"
//            global.myImageView.image = #imageLiteral(resourceName: "rock")
//        case 1:
//            global.rowString = "paper"
//            global.myImageView.image = #imageLiteral(resourceName: "paper")
//        case 2:
//            global.rowString = "scissors"
//            global.myImageView.image = #imageLiteral(resourceName: "scissors")
//        case 3:
//            global.rowString = "meteor"
//            global.myImageView.image = #imageLiteral(resourceName: "meteor")
//        case 4:
//            global.rowString = "dynamite"
//            global.myImageView.image = #imageLiteral(resourceName: "dynamite")
//        case 5:
//            global.rowString = "nuclearBomb"
//            global.myImageView.image = #imageLiteral(resourceName: "nuclearBomb")
//        case 6:
//            global.rowString = "cockroach"
//            global.myImageView.image = #imageLiteral(resourceName: "cockroach")
//        case 7:
//            global.rowString = "car"
//            global.myImageView.image = #imageLiteral(resourceName: "car")
//        case 8:
//            global.rowString = "dinosaur"
//            global.myImageView.image = #imageLiteral(resourceName: "dinosaur")
//        //              This is what WAS there. I used an IMAGE LITERAL to replace
//        //                UIImage.init(assetIdentifier: ((UIImage.AssetIdentifier(rawValue: (rowString)) ?? UIImage.AssetIdentifier(rawValue: rowString))!))
//        case 9:
//            global.rowString = "boot"
//            global.myImageView.image = #imageLiteral(resourceName: "boot")
//        //                    UIImage.init(assetIdentifier: ((UIImage.AssetIdentifier(rawValue: (rowString)) ?? UIImage.AssetIdentifier(rawValue: rowString))!))
//        default:
//            global.rowString = ""
//            global.myImageView.image = #imageLiteral(resourceName: "Start")
//            return global.myImageView
//    }
//    global.myView.addSubview(global.myImageView)
//    global.myImageView.transform = CGAffineTransform(rotationAngle: 270 * (.pi/180))
//
//    return global.myImageView
//}


//
//extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return global.choices.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//    
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! Cell
////        cell.weaponButton?.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((global.choices.randomElement()!))))!), for: .normal)
////        print(cell.weaponButton.currentImage?.description)
////        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        global.userSign = weapon?.weaponButton.currentTitle
////        weapon?.weaponButton?.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((global.choices.randomElement()!))))!), for: .normal)
//    }
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//}
