//
//  GameOverViewController.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 1/2/21.
//

import UIKit
import GoogleMobileAds

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var gameStatus: UILabel!
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStatus.text = "You \(GameState().battle(userSign: GameState.Sign(rawValue: global.userSign!)!, opponentSign: GameState.Sign(rawValue: global.opponentSign!)!).rawValue.capitalized)!"
        gameStatus.textColor = .white
        playAgain.layer.cornerRadius = 25
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                print("ruh roh")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
    }
    @IBAction func playAgainButton(_ sender: UIButton) {
       
//        loadAds()
        global.adPrepCount += 1
        print(global.adPrepCount)
        if global.adPrepCount == 1 {
//            showAd()
            loadAds()
            global.adPrepCount = 0

        } else {
            showStartScreen()
        }
        print(global.adPrepCount)
    }
}
extension GameOverViewController: GADFullScreenContentDelegate {
    
    func loadAds() {
    
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
            showStartScreen()
          print("Ad wasn't ready")
        }
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content. error: \(error.localizedDescription)")
        
    }
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        showStartScreen()
    }
    
}
