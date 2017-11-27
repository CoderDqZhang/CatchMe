//
//  TopUpModel.swift
//  CatchMe
//
//  Created by Zhang on 27/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopUpModel : NSObject, NSCoding{
    
    var comment : AnyObject!
    var createBy : AnyObject!
    var createTime : Int!
    var exchargeRete : AnyObject!
    var id : Int!
    var rechargeCoin : Int!
    var rechargeCoinReal : Int!
    var rechargeMoney : Float!
    var updateBy : AnyObject!
    var updateTime : Int!
    var validFlag : Int!
    var version : AnyObject!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        comment = dictionary["comment"] as AnyObject
        createBy = dictionary["createBy"] as AnyObject
        createTime = dictionary["createTime"] as? Int
        exchargeRete = dictionary["exchargeRete"] as AnyObject
        id = dictionary["id"] as? Int
        rechargeCoin = dictionary["rechargeCoin"] as? Int
        rechargeCoinReal = dictionary["rechargeCoinReal"] as? Int
        rechargeMoney = dictionary["rechargeMoney"] as? Float
        updateBy = dictionary["updateBy"] as AnyObject
        updateTime = dictionary["updateTime"] as? Int
        validFlag = dictionary["validFlag"] as? Int
        version = dictionary["version"] as AnyObject
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if comment != nil{
            dictionary["comment"] = comment
        }
        if createBy != nil{
            dictionary["createBy"] = createBy
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if exchargeRete != nil{
            dictionary["exchargeRete"] = exchargeRete
        }
        if id != nil{
            dictionary["id"] = id
        }
        if rechargeCoin != nil{
            dictionary["rechargeCoin"] = rechargeCoin
        }
        if rechargeCoinReal != nil{
            dictionary["rechargeCoinReal"] = rechargeCoinReal
        }
        if rechargeMoney != nil{
            dictionary["rechargeMoney"] = rechargeMoney
        }
        if updateBy != nil{
            dictionary["updateBy"] = updateBy
        }
        if updateTime != nil{
            dictionary["updateTime"] = updateTime
        }
        if validFlag != nil{
            dictionary["validFlag"] = validFlag
        }
        if version != nil{
            dictionary["version"] = version
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        comment = aDecoder.decodeObject(forKey: "comment") as AnyObject
        createBy = aDecoder.decodeObject(forKey: "createBy") as AnyObject
        createTime = aDecoder.decodeObject(forKey: "createTime") as? Int
        exchargeRete = aDecoder.decodeObject(forKey: "exchargeRete") as AnyObject
        id = aDecoder.decodeObject(forKey: "id") as? Int
        rechargeCoin = aDecoder.decodeObject(forKey: "rechargeCoin") as? Int
        rechargeCoinReal = aDecoder.decodeObject(forKey: "rechargeCoinReal") as? Int
        rechargeMoney = aDecoder.decodeObject(forKey: "rechargeMoney") as? Float
        updateBy = aDecoder.decodeObject(forKey: "updateBy") as AnyObject
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as? Int
        validFlag = aDecoder.decodeObject(forKey: "validFlag") as? Int
        version = aDecoder.decodeObject(forKey: "version") as AnyObject
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if comment != nil{
            aCoder.encode(comment, forKey: "comment")
        }
        if createBy != nil{
            aCoder.encode(createBy, forKey: "createBy")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if exchargeRete != nil{
            aCoder.encode(exchargeRete, forKey: "exchargeRete")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if rechargeCoin != nil{
            aCoder.encode(rechargeCoin, forKey: "rechargeCoin")
        }
        if rechargeCoinReal != nil{
            aCoder.encode(rechargeCoinReal, forKey: "rechargeCoinReal")
        }
        if rechargeMoney != nil{
            aCoder.encode(rechargeMoney, forKey: "rechargeMoney")
        }
        if updateBy != nil{
            aCoder.encode(updateBy, forKey: "updateBy")
        }
        if updateTime != nil{
            aCoder.encode(updateTime, forKey: "updateTime")
        }
        if validFlag != nil{
            aCoder.encode(validFlag, forKey: "validFlag")
        }
        if version != nil{
            aCoder.encode(version, forKey: "version")
        }
        
    }
    
}
