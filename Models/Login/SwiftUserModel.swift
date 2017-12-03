//
//  SwiftUserModel.swift
//  CatchMe
//
//  Created by Zhang on 02/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SwiftUserModel : NSObject, NSCoding{
    
    var coinAmount : Int!
    var gender : Int!
    var id : Int!
    var neteaseAccountId : String!
    var neteaseToken : String!
    var photo : String!
    var registerType : Int!
    var shareCode : String!
    var shareNum : AnyObject!
    var shareStatus : Int!
    var telephone : String!
    var token : AnyObject!
    var userName : String!
    var wechatOpenid : AnyObject!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        coinAmount = dictionary["coinAmount"] as? Int
        gender = dictionary["gender"] as? Int
        id = dictionary["id"] as? Int
        neteaseAccountId = dictionary["neteaseAccountId"] as? String
        neteaseToken = dictionary["neteaseToken"] as? String
        photo = dictionary["photo"] as? String
        registerType = dictionary["registerType"] as? Int
        shareCode = dictionary["shareCode"] as? String
        shareNum = dictionary["shareNum"] as AnyObject
        shareStatus = dictionary["shareStatus"] as? Int
        telephone = dictionary["telephone"] as? String
        token = dictionary["token"] as AnyObject
        userName = dictionary["userName"] as? String
        wechatOpenid = dictionary["wechatOpenid"] as AnyObject
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if coinAmount != nil{
            dictionary["coinAmount"] = coinAmount
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if id != nil{
            dictionary["id"] = id
        }
        if neteaseAccountId != nil{
            dictionary["neteaseAccountId"] = neteaseAccountId
        }
        if neteaseToken != nil{
            dictionary["neteaseToken"] = neteaseToken
        }
        if photo != nil{
            dictionary["photo"] = photo
        }
        if registerType != nil{
            dictionary["registerType"] = registerType
        }
        if shareCode != nil{
            dictionary["shareCode"] = shareCode
        }
        if shareNum != nil{
            dictionary["shareNum"] = shareNum
        }
        if shareStatus != nil{
            dictionary["shareStatus"] = shareStatus
        }
        if telephone != nil{
            dictionary["telephone"] = telephone
        }
        if token != nil{
            dictionary["token"] = token
        }
        if userName != nil{
            dictionary["userName"] = userName
        }
        if wechatOpenid != nil{
            dictionary["wechatOpenid"] = wechatOpenid
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        coinAmount = aDecoder.decodeObject(forKey: "coinAmount") as? Int
        gender = aDecoder.decodeObject(forKey: "gender") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        neteaseAccountId = aDecoder.decodeObject(forKey: "neteaseAccountId") as? String
        neteaseToken = aDecoder.decodeObject(forKey: "neteaseToken") as? String
        photo = aDecoder.decodeObject(forKey: "photo") as? String
        registerType = aDecoder.decodeObject(forKey: "registerType") as? Int
        shareCode = aDecoder.decodeObject(forKey: "shareCode") as? String
        shareNum = aDecoder.decodeObject(forKey: "shareNum") as AnyObject
        shareStatus = aDecoder.decodeObject(forKey: "shareStatus") as? Int
        telephone = aDecoder.decodeObject(forKey: "telephone") as? String
        token = aDecoder.decodeObject(forKey: "token") as AnyObject
        userName = aDecoder.decodeObject(forKey: "userName") as? String
        wechatOpenid = aDecoder.decodeObject(forKey: "wechatOpenid") as AnyObject
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if coinAmount != nil{
            aCoder.encode(coinAmount, forKey: "coinAmount")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if neteaseAccountId != nil{
            aCoder.encode(neteaseAccountId, forKey: "neteaseAccountId")
        }
        if neteaseToken != nil{
            aCoder.encode(neteaseToken, forKey: "neteaseToken")
        }
        if photo != nil{
            aCoder.encode(photo, forKey: "photo")
        }
        if registerType != nil{
            aCoder.encode(registerType, forKey: "registerType")
        }
        if shareCode != nil{
            aCoder.encode(shareCode, forKey: "shareCode")
        }
        if shareNum != nil{
            aCoder.encode(shareNum, forKey: "shareNum")
        }
        if shareStatus != nil{
            aCoder.encode(shareStatus, forKey: "shareStatus")
        }
        if telephone != nil{
            aCoder.encode(telephone, forKey: "telephone")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "userName")
        }
        if wechatOpenid != nil{
            aCoder.encode(wechatOpenid, forKey: "wechatOpenid")
        }
        
    }
    
}
