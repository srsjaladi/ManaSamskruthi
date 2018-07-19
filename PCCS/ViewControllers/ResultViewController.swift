//
//  ResultViewController.swift
//  Rainer
//
//  Created by Sivaramsingh on 09/06/18.
//  Copyright © 2018 Self. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var txtResultnews: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    var strInfo : String = ""
    var strName : String = ""
    var statusCode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var value : String = ""
        if strName != ""
        {
           value = String(format:"\(strName) : \(strInfo)")
        }
        else
        {
            value = strInfo
        }
        
        self.imgView.image = statusCode ? UIImage(named: "DetailsFound") : UIImage(named: "NoDetailsFound")
        self.txtResultnews.attributedText =  getAttributedStringWithLineSpacing(value, lineSpacing: 10.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ScanQrCode", style: .done, target: self, action: #selector(ResultViewController.backToInitial))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @objc func backToInitial(sender: AnyObject) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeNextViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    fileprivate func getAttributedStringWithLineSpacing(_ string: String, lineSpacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineSpacing = lineSpacing
        
        let attrString = NSMutableAttributedString(string: string)
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        return attrString
    }

}
