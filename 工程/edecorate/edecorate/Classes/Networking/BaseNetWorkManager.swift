//
//  BaseNetWorkManager.swift
//  edecorate
//
//  Created by shadowPriest on 15/7/12.
//
//

import UIKit

class BaseNetWorkManager: NSObject {
   
    static let sharedInstance = BaseNetWorkManager()
    override init(){
        
    }
    
    func defaultGetWithMethod(method:String,parameters:AnyObject,complete:(responseObject:AnyObject) -> ()){
        let urlString = NSString.createResponseURLWithMethod(method, params: parameters.JSONString())//NSString.createSignWithMethod(method, params:parameters.JSONString())
        var request = NSMutableURLRequest()
        request.URL = NSURL(string: urlString)
        let contentType = "text/html"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//        NSURLConnection.sendSynchronousRequest(request, returningResponse: <#AutoreleasingUnsafeMutablePointer<NSURLResponse?>#>, error: <#NSErrorPointer#>)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if (data != nil){
                let retStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                if (retStr == nil){
                    return;
                }
                let retJson = NSString.decodeFromPercentEscapeString(retStr!.decryptWithDES())
                complete(responseObject: retJson.objectFromJSONString())
            }
        }
    }
}
