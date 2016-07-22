//
//  RequestNetwork.swift
//  SwiftZQ
//
//  Created by XGJ on 16/7/22.
//  Copyright © 2016年 XGJ. All rights reserved.
//

import UIKit
import Alamofire

class RequestNetwork: NSObject {
    typealias CompletionHandler = (dict: NSMutableArray?) -> ()
    
    func GET(URLString:String, parameters:[String:AnyObject]?, showHUD:Bool = true, success: CompletionHandler) {
        Alamofire.time_t
        Alamofire.request(.GET,URLString,parameters: parameters).validate().responseJSON { (responseJSON) in
            if responseJSON.result.isSuccess{
                let str = NSString(data: responseJSON.data!,encoding:NSUTF8StringEncoding)
                let testData:NSData = str!.dataUsingEncoding(NSUTF8StringEncoding)!
                let dic:NSDictionary = try!NSJSONSerialization.JSONObjectWithData(testData, options:NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                let array = dic["data"]
                let muarray:NSMutableArray = [];
                for var index = 0;index<array?.count;index += 1
                {
                    let model = HListModel()
                    let modict = array![index]
                    model.id = (modict["id"] as?String)!
                    model.title = (modict["title"] as?String)!
                    let listmd = modict["lists"]
                    let listay:NSMutableArray = []
                    for var iex = 0;iex<listmd?!.count;iex += 1
                    {
                        let listmodict = listmd!![iex]
                        let listmodel = ListClassModel()
                        listmodel.id       = (listmodict["id"] as?String)!
                        listmodel.title    = (listmodict["title"] as?String)!
                        listmodel.videoId  = (listmodict["videoId"] as?String)!
                        listmodel.spic     = (listmodict["spic"] as?String)!
                        listmodel.nickname = (listmodict["nickname"] as?String)!
                        listmodel.online   = (listmodict["online"] as?String)!
                        listay .addObject(listmodel)
                    }
                    model.lists = listay
                    muarray .addObject(model)
                }
                success(dict: muarray)
            }
            else
            {
                if responseJSON.result.isFailure
                {
                    NSLog("网络错误", "错误");
                }
                
            }
            
        }
    }

}
