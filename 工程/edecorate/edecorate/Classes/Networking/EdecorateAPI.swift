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
        static let GetDecorationDeclare = "get.decoration.declare"
        static let GetDecorationDeclaredetails = "get.decoraton.declaredetails"
    }
    class func loginWithParameters(parameter:AnyObject,completionHandler:((AnyObject?,NSError?) -> ())){
        self.sharedInstance.defaultGetWithMethod(Constant.LoginDomain, parameters: parameter, complete: completionHandler)
    }
    class func getdecoratonDeclaredetail(parameter:AnyObject,completionHandler:((AnyObject?,NSError?)->())){
        self.sharedInstance.defaultGetWithMethod(Constant.GetDecorationDeclaredetails, parameters: parameter, complete: completionHandler)
    }
    class func getDecorationDeclare(parameter:AnyObject,completionHandler:((AnyObject?,NSError?)->())){
        self.sharedInstance.defaultGetWithMethod(Constant.GetDecorationDeclare, parameters: parameter, complete: completionHandler)
    }
}
