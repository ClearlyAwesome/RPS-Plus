//
//  SettingsViewController.swift
//  randomGenerator
//
//  Created by R C on 9/19/21.
//

import UIKit
//for email
import MessageUI
//for purchasing no ads
import StoreKit
//to save the choice to buy
import SwiftKeychainWrapper
//for privacy policy and terms & conditions
import WebKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingMainView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    let keychainData = KeychainWrapper.standard.integer(forKey: "purchased")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton?.layer.cornerRadius = 20.0
        settingMainView?.layer.cornerRadius = 20.0
        settingMainView.alpha = 0.95
        print(keychainData)
        SKPaymentQueue.default().add(self)
     
        
//        if keychainData != "" {
//            global.adViewHeight.constant = 0.0
//        }
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
    }
    func checkForPurchase() {

    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func privacyPolicy(_ sender: UIButton) {
        global.webString = "https://appsbyme.weebly.com/uploads/7/0/7/2/70728275/randomizer_privacy_policy.pdf"
        let vc = WebViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
    }
    
    @IBAction func emailUs(_ sender: UIButton) {
        presentEmail()
    }
    @IBAction func noAds(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.ads.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
            global.adViewHeight.constant = 0.0
        }
    }
    
    
}

//MARK: - MailerView Extension
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    //MARK: - Setting up the email
    func presentEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["cleary1robert1@gmail.com"])
        composeVC.setSubject("Support Request")
        composeVC.setMessageBody("RPS+ staff, \n \n", isHTML: false)
        // Present the view controller modally.
        present(composeVC, animated: true, completion: nil)
        
    }
    
    // MARK: What to do with email sent protocols
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
            case .cancelled:
                print("Cancelled")
                controller.dismiss(animated: true, completion: nil)
            case .failed:
                print("Failed to send")
            case .saved:
                print("Saved")
                controller.dismiss(animated: true, completion: nil)
            case .sent:
                print("Sent")
                controller.dismiss(animated: true, completion: nil)
            @unknown default:
                print("Ruh-Roh")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - StoreKit Extension
extension SettingsViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    enum Product: String, CaseIterable {
        case ads = "com.Cleary.ads"
        case other = "some other content"
    }
 
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first {
            print("Product is available")
            //buy function
            self.purchase(aproduct: oProduct)
        } else {
            print("Product is not available")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    print("Customer is about to purchase")
                case .purchased:
                    print("Purchase complete")
                    KeychainWrapper.standard.set(transaction.transactionState.rawValue , forKey: "purchased")
//                    KeychainWrapper.standard.set(true, forKey: transaction.transactionState.rawValue)
//                    KeychainWrapper.standard.set(transaction.transactionState.rawValue, forKey: "purchased")
//                    KeychainWrapper.standard.set(true, forKey: transaction.transactionState)
//                    KeychainWrapper.standard.set(true, forKey: transaction.payment.productIdentifier)
                    print(transaction.payment.productIdentifier)
                    print(keychainData)
                    
                    //                    main.googleAdBanner?.isHidden = true
                    SKPaymentQueue.default().finishTransaction(transaction)
                    dismiss(animated: true, completion: nil)
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("Purchase failed")
                case .deferred:
                    print("deferred")
                case .restored:
                    print("restored")
                @unknown default:
                    print("ruh-roh")
            }
            
        }
        
    }
    func purchase(aproduct: SKProduct) {
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
}
