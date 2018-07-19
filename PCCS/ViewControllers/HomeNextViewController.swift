//
//  HomeNextViewController.swift
//  Rainer
//
//  Created by Sivaramsingh on 08/06/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit

class HomeNextViewController: UIViewController {

    
    @IBOutlet weak var btnLink: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UIView.transition(with: self.view!, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
            self.navigationController?.popToRootViewController(animated: false)
        }, completion: nil)
    }
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.daledietrich.com"]];

    @IBAction func btnLinkClicked(_ sender: Any) {
        
        if let url = URL(string: "https://manasamskriti.org") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
