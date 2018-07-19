//
//  KollectinAPI.swift
//  Kollectin
//
//  Created by Pablo on 1/4/16.
//  Copyright © 2016 Pablo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private struct Strings{
    static let TOKEN_HEADER_KEY = "x-access-token"
    static let CONTENT_TYPE = "Content-Type"
    
}

private struct ContentTypes {

    static let applicationJSON = "application/json"
}

class ManaSamskruthiAPI {

    static let sharedInstance = ManaSamskruthiAPI()
    fileprivate let alamoFireManager : Alamofire.SessionManager!
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20 // seconds
        configuration.timeoutIntervalForResource = 20
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    fileprivate func getStatusCodeFrom(_ response: DataResponse<Any>  ) -> Int {
        if let httpError = response.result.error?._code {
            return httpError
        } else {
            return (response.response?.statusCode)!
        }
    }
    
    fileprivate func validateResponseSuccess(_ response: DataResponse<Any>) -> Bool {
        print("Request: \(response.request!)")
        let success = response.result.isSuccess && (self.getStatusCodeFrom(response) == 200)
        print(success ? "SUCCESS" : "FAILURE")
        return success
    }
    
    //API Calls
        
    func signIn(
        _ email: String,
        password: String,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let parameters: [String: Any] = [
            "email": "sriksatya@outlook.com",
            "password": "admin@2018"
        ]
        
         let path: String = "https://manasamskriti.org/webservices/login.php"
             self.alamoFireManager.request(path, method:.post, parameters: parameters, encoding: JSONEncoding.default,headers: nil).validate(statusCode: 200..<600).responseJSON { response in
            
                
                let success = self.validateResponseSuccess(response)
                
                if (success)
                {
                    let object = response.result.value as! NSDictionary
                    let json = JSON(object)
                    let dataObj = json["responseData"]
                    let status = json["status"].boolValue
                    
                    handler(status, dataObj as AnyObject)
                }
                else
                {
                    handler(false, nil)
                }
                
        }
        
    }
    
    
    func sendQrCode(
        _ code: String,
        handler: @escaping (_ success: Bool, _ name: String?, _ response: String?) -> Void
        )
    {
        let parameters: [String: Any] = [
            "QR_code": code
        ]
        
        let path: String = "https://manasamskriti.org/webservices/qrcode.php"
        self.alamoFireManager.request(path, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil).validate(statusCode: 200..<600).responseJSON { response in
            
            let success = self.validateResponseSuccess(response)
            
            if (success)
            {
                let object = response.result.value as! NSDictionary
                let json = JSON(object)
                let dataObj = json["message"].stringValue
                let status = json["status"].boolValue
                let username = (json["first_name"].stringValue +  json["last_name"].stringValue)
                
                handler(status,username, dataObj)
            }
            else
            {
                handler(false,"", "")
            }
            
        }
        
    }
    

}

