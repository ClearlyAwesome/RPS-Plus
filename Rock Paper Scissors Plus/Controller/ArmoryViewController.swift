//
//  ArmoryViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 12/13/20.
//

import UIKit
//MARK: - GlobalTwo Functionality
class GlobalTwo {
    var weaponA: String?
    var weaponB: String?
    var weaponC: String?
    var myView = UIView(frame: CGRect(x: -20, y: -20, width: 150, height: 150))
    var myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    
    
}
let globalTwo = GlobalTwo()
//MARK: - Main Class
class ArmoryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let choices = ["rock", "paper", "scissors", "meteor", "dynamite", "nuclearBomb", "cockroach", "car", "dinosaur", "boot"]
    @IBOutlet weak var AllWeaponsStack: UIStackView!
    @IBOutlet weak var pickerOne: UIPickerView!
    @IBOutlet weak var pickerTwo: UIPickerView!
    @IBOutlet weak var pickerThree: UIPickerView!
    @IBOutlet weak var WeaponOneStack: UIStackView!
    @IBOutlet weak var WeaponTwoStack: UIStackView!
    @IBOutlet weak var WeaponThreeStack: UIStackView!
    
    var rowString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOne.dataSource = self
        pickerOne.delegate = self
        pickerTwo.dataSource = self
        pickerTwo.delegate = self
        pickerThree.dataSource = self
        pickerThree.delegate = self
        pickerOne.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        pickerTwo.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        pickerThree.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        AllWeaponsStack.translatesAutoresizingMaskIntoConstraints = true
        pickerOne.translatesAutoresizingMaskIntoConstraints = true
        pickerTwo.translatesAutoresizingMaskIntoConstraints = true
        pickerThree.translatesAutoresizingMaskIntoConstraints = true
        WeaponOneStack.alignment = .center
        WeaponOneStack.distribution = .equalSpacing
        WeaponTwoStack.alignment = .center
        WeaponTwoStack.distribution = .equalSpacing
        WeaponThreeStack.alignment = .center
        WeaponThreeStack.distribution = .equalSpacing
        AllWeaponsStack.alignment = .fill
        AllWeaponsStack.distribution = .fillEqually
        AllWeaponsStack.spacing = 0
        let pickOne = pickerOne.selectedRow(inComponent: 0)
        print(pickOne)
        
        
        
        
    }
    //MARK: - Submit Functionality
    @IBAction func submit(_ sender: UIButton) {
        numberToTextA()
        //Setting the image of the weapons on the home screen.
        global.weaponOne.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((globalTwo.weaponA! ))))!), for: .normal)
        global.weaponTwo.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((globalTwo.weaponB! ))))!), for: .normal)
        global.weaponThree.setImage(UIImage.init(assetIdentifier: (UIImage.AssetIdentifier(rawValue: ((globalTwo.weaponC! ))))!), for: .normal)
        //Setting the button's title on home screen.
        global.weaponOne.setTitle(globalTwo.weaponA, for: .normal)
        global.weaponTwo.setTitle(globalTwo.weaponB, for: .normal)
        global.weaponThree.setTitle(globalTwo.weaponC, for: .normal)
        global.shooter.isEnabled = false
        //        UserDefaults.standard.set(pickerOne.selectedRow(inComponent: 0), forKey: "pickOne")
//        let value = UserDefaults.standard.integer(forKey: "pickOne")
//        print(value)
        //Simple dismiss function.
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: -Really long IF/ELSE Statement
    func numberToTextA () {
        //Picker One IF/ELSE Statement
        if pickerOne.selectedRow(inComponent: 0) == 0 {
            globalTwo.weaponA = "rock"
        } else if pickerOne.selectedRow(inComponent: 0) == 1 {
            globalTwo.weaponA = "paper"
        } else if pickerOne.selectedRow(inComponent: 0) == 2 {
            globalTwo.weaponA = "scissors"
        } else if pickerOne.selectedRow(inComponent: 0) == 3 {
            globalTwo.weaponA = "meteor"
        } else if pickerOne.selectedRow(inComponent: 0) == 4 {
            globalTwo.weaponA = "dynamite"
        } else if pickerOne.selectedRow(inComponent: 0) == 5 {
            globalTwo.weaponA = "nuclearBomb"
        } else if pickerOne.selectedRow(inComponent: 0) == 6 {
            globalTwo.weaponA = "cockroach"
        } else if pickerOne.selectedRow(inComponent: 0) == 7 {
            globalTwo.weaponA = "car"
        } else if pickerOne.selectedRow(inComponent: 0) == 8 {
            globalTwo.weaponA = "dinosaur"
        } else if pickerOne.selectedRow(inComponent: 0) == 9 {
            globalTwo.weaponA = "boot"
        }    else {
            globalTwo.weaponA = "rock"
        }
        //Picker Two IF/ELSE Statement
        if pickerTwo.selectedRow(inComponent: 0) == 0 {
            globalTwo.weaponB = "rock"
        } else if pickerTwo.selectedRow(inComponent: 0) == 1 {
            globalTwo.weaponB = "paper"
        } else if pickerTwo.selectedRow(inComponent: 0) == 2 {
            globalTwo.weaponB = "scissors"
        } else if pickerTwo.selectedRow(inComponent: 0) == 3 {
            globalTwo.weaponB = "meteor"
        } else if pickerTwo.selectedRow(inComponent: 0) == 4 {
            globalTwo.weaponB = "dynamite"
        } else if pickerTwo.selectedRow(inComponent: 0) == 5 {
            globalTwo.weaponB = "nuclearBomb"
        } else if pickerTwo.selectedRow(inComponent: 0) == 6 {
            globalTwo.weaponB = "cockroach"
        } else if pickerTwo.selectedRow(inComponent: 0) == 7 {
            globalTwo.weaponB = "car"
        } else if pickerTwo.selectedRow(inComponent: 0) == 8 {
            globalTwo.weaponB = "dinosaur"
        } else if pickerTwo.selectedRow(inComponent: 0) == 9 {
            globalTwo.weaponB = "boot"
        }    else {
            globalTwo.weaponB = "rock"
        }
        //Picker Three IF/ELSE Statement
        if pickerThree.selectedRow(inComponent: 0) == 0 {
            globalTwo.weaponC = "rock"
        } else if pickerThree.selectedRow(inComponent: 0) == 1 {
            globalTwo.weaponC = "paper"
        } else if pickerThree.selectedRow(inComponent: 0) == 2 {
            globalTwo.weaponC = "scissors"
        } else if pickerThree.selectedRow(inComponent: 0) == 3 {
            globalTwo.weaponC = "meteor"
        } else if pickerThree.selectedRow(inComponent: 0) == 4 {
            globalTwo.weaponC = "dynamite"
        } else if pickerThree.selectedRow(inComponent: 0) == 5 {
            globalTwo.weaponC = "nuclearBomb"
        } else if pickerThree.selectedRow(inComponent: 0) == 6 {
            globalTwo.weaponC = "cockroach"
        } else if pickerThree.selectedRow(inComponent: 0) == 7 {
            globalTwo.weaponC = "car"
        } else if pickerThree.selectedRow(inComponent: 0) == 8 {
            globalTwo.weaponC = "dinosaur"
        } else if pickerThree.selectedRow(inComponent: 0) == 9 {
            globalTwo.weaponC = "boot"
        }    else {
            globalTwo.weaponC = "rock"
        }
    }
    //MARK: -PickerView Stuff
    //Functionality of the app's pickerView
    //This indicates how many columns
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //This indicates how many rows. Use a .count function here.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    //This indicates the title for the row. Use some sort of GET like below.
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        print(choices[row])
        return choices[row]
    }
    //This indicates that a selection was made
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String {
        pickerOne.selectRow(row, inComponent: 0, animated: true)
        pickerTwo.selectRow(row, inComponent: 0, animated: true)
        pickerThree.selectRow(row, inComponent: 0, animated: true)
        print(rowString)
        return rowString
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    
    //MARK: -UIPickerViewDelegate
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        globalTwo.myView = UIView(frame: CGRect(x: -20, y: -20, width: 150, height: 150))
        globalTwo.myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        
        switch row {
            case 0:
                rowString = "rock"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "rock")
            case 1:
                rowString = "paper"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "paper")
            case 2:
                rowString = "scissors"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "scissors")
            case 3:
                rowString = "meteor"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "meteor")
            case 4:
                rowString = "dynamite"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "dynamite")
            case 5:
                rowString = "nuclearBomb"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "nuclearBomb")
            case 6:
                rowString = "cockroach"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "cockroach")
            case 7:
                rowString = "car"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "car")
            case 8:
                rowString = "dinosaur"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "dinosaur")
            //              This is what WAS there. I used an IMAGE LITERAL to replace
            //                UIImage.init(assetIdentifier: ((UIImage.AssetIdentifier(rawValue: (rowString)) ?? UIImage.AssetIdentifier(rawValue: rowString))!))
            case 9:
                rowString = "boot"
                globalTwo.myImageView.image = #imageLiteral(resourceName: "boot")
            //                    UIImage.init(assetIdentifier: ((UIImage.AssetIdentifier(rawValue: (rowString)) ?? UIImage.AssetIdentifier(rawValue: rowString))!))
            default:
                rowString = ""
                globalTwo.myImageView.image = #imageLiteral(resourceName: "Start")
                return globalTwo.myImageView
        }
        globalTwo.myView.addSubview(globalTwo.myImageView)
        globalTwo.myImageView.transform = CGAffineTransform(rotationAngle: 270 * (.pi/180))
        
        return globalTwo.myImageView
    }
}
