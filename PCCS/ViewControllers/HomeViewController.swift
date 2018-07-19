//
//  HomeViewController.swift
//  PCCS
//
//  Created by Sivaramsingh on 05/05/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController,URLSessionDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtfldEmail: UITextField!
    @IBOutlet weak var txtfldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.value(forKey: "isLogin") != nil
        {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let settingsVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNextViewController") as! HomeNextViewController
            self.navigationController?.pushViewController(settingsVC, animated: false)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
    }
    
    @nonobjc func textFieldDidEndEditing(textField: UITextField)
    {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString rString: String) -> Bool {
        
        var txtAfterUpdate: NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: rString) as NSString
       
        return true
    }
    

    @IBAction func btnLoginClicked(_ sender: Any) {
        self.signIn()
        if self.txtfldPassword.text == "" || self.txtfldEmail.text == "" || self.txtfldPassword.text == nil || self.txtfldEmail.text == nil  {
            
            let alertController = UIAlertController(title: "Alert", message: "Please provide all require details.", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        else if self.txtfldPassword.text != "" && self.txtfldEmail.text != ""
        {
            self.signIn()
        }
        else if self.txtfldPassword.text != "" && self.txtfldEmail.text != ""
        {
            self.signIn()
        }
        
        
        
    }
    
    fileprivate func signIn() {
        MBProgressHUD.showHUDAddedGlobal()
        ManaSamskruthiAPI.sharedInstance.signIn((self.txtfldEmail.text?.lowercased())!, password: self.txtfldPassword.text!) { (success, response) -> Void in
            
            MBProgressHUD.dismissGlobalHUD()
            if (success) {
                UserDefaults.standard.set(1, forKey: "isLogin")
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let settingsVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNextViewController") as! HomeNextViewController
                self.navigationController?.pushViewController(settingsVC, animated: true)
            }
            else {
               
                let alertController = UIAlertController(title: "Alert", message: "Invalid credentials.", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
                
//                UserDefaults.standard.set(1, forKey: "isLogin")
//                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let settingsVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNextViewController") as! HomeNextViewController
//                self.navigationController?.pushViewController(settingsVC, animated: true)
                
            }
        }
    }
    
}
