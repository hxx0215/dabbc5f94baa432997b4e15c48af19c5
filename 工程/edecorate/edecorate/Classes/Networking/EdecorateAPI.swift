//
//  EdecorateAPI.swift
//  edecorate
//
//  Created by shadowPriest on 15/7/12.
//
//

import UIKit

class EdecorateAPI: BaseNetWorkManager {
    struct Constant {
        static let LoginDomain = "get.user.login"
        static let GetDecoratonDeclaredetails = "get.decoraton.declaredetails"
    }
    class func loginWithParameters(parameter:AnyObject,completionHandler:((AnyObject?,NSError?) -> ())){
        self.sharedInstance.defaultGetWithMethod(Constant.LoginDomain, parameters: parameter, complete: completionHandler)
//        self.sharedInstance.defaultGetWithMethod(Constant.LoginDomain, parameters: parameter, complete: completionHandler)
    }
    class func getdecoratonDeclaredetail(parameter:AnyObject,completionHandler:(AnyObject,NSError->())){
        
    }
}
