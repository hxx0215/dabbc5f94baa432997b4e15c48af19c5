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
    }
    class func loginWithParameters(parameter:AnyObject,completionHandler:(AnyObject->())){
        self.sharedInstance.defaultGetWithMethod(Constant.LoginDomain, parameters: parameter, complete: completionHandler)
    }
}
