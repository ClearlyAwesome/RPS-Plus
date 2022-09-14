//
//  MailUsViewController.swift
//  GeoWorld
//
//  Created by R C on 7/3/21.
//  Copyright © 2021 R C. All rights reserved.
//

import UIKit
import MessageUI

class MailUsViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    let composeVC = MFMailComposeViewController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        composeVC.mailComposeDelegate = self
        
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        configuredMailComposeViewController()
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.delegate = self
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }

//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
//    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        composeVC.dismiss(animated: true, completion: nil)
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    }
    
    
    
    
    
//    func presentEmail() {
//        composeVC.mailComposeDelegate = self
//        // Configure the fields of the interface.
//        composeVC.setToRecipients(["cleary1robert1@gmail.com"])
//        composeVC.setSubject("Hello!")
//        composeVC.setMessageBody("Hello from your app!", isHTML: false)
//        // Present the view controller modally.
//        self.present(composeVC, animated: true, completion: nil)
//
//    }
   
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        composeVC.mailComposeDelegate = self
//        switch result.rawValue {
//        case MFMailComposeResult.cancelled.rawValue :
//            print("Cancelled")
//
//        case MFMailComposeResult.failed.rawValue :
//            print("Failed")
//
//        case MFMailComposeResult.saved.rawValue :
//            print("Saved")
//
//        case MFMailComposeResult.sent.rawValue :
//            print("Sent")
//
//
//
//        default: break
//
//
//        }
//
//        self.dismiss(animated: true, completion: nil)
//
//    }
//}
