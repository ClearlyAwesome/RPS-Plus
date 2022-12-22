//
//  Extensions.swift
//  Rock Paper Scissors Plus
//
//  Created by R C on 10/10/21.
//

import UIKit
import AVFoundation
import GoogleMobileAds

//MARK: - UIViewController Extensions
extension UIViewController {
    
    func showStartScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "startScreen")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    func showSettings() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sb = storyboard.instantiateViewController(withIdentifier: "settings")
        sb.modalTransitionStyle = .coverVertical
        sb.modalPresentationStyle = .overCurrentContext
        present(sb, animated: true, completion: nil)
    }
    @objc func showMyAlert() {
        let alert = UIAlertController(title: "Limit Reached!", message: "Please select only 3 weapons", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
//    func showEmailSupport() {
//        let vc = MailUsViewController()
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
//    }
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
extension GamePlayViewController: GADBannerViewDelegate, GADFullScreenContentDelegate {
    
    func setUpBanner() {
        GADInterstitialAd.load(withAdUnitID: "google ad unit id #", request: request, completionHandler: {ad, error in
            if let error = error {
                print("failed to load ad \(error)")
                return
            }
            self.oInterstitial = ad
            self.oInterstitial.fullScreenContentDelegate = self
        })
        
        if oInterstitial != nil {
            oInterstitial.present(fromRootViewController: self)
        } else {
            print("Ad didn't load or wasn't ready")
        }
        //Change this add Unit id to below when ready to publish
        //                oInterstitial.adUnitID = "ad unit"
    }
    //    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
    //        print("Error: \(error.localizedDescription)")
    //    }
    //    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    //        print(<#T##Any#>)
    //    }
    
    //MARK: - Google Ad Functions
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Add banner to view and add constraints as above.
        print("ad received")
        
    }
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        print("ad error")
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
        //        bannerView.isHidden = true
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
    
}

