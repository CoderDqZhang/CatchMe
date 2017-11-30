//
//  MyCatchDollsModel.swift
//  CatchMe
//
//  Created by Zhang on 27/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyCatchDollsModel : NSObject, NSCoding{
    
    var deliveryStatus : Int!
    var desc : String!
    var id : Int!
    var images : [String]!
    var name : String!
    var price : Int!
    var skuId : Int!
    var time : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        deliveryStatus = dictionary["deliveryStatus"] as? Int
        desc = dictionary["desc"] as? String
        id = dictionary["id"] as? Int
        images = dictionary["images"] as? [String]
        name = dictionary["name"] as? String
        price = dictionary["price"] as? Int
        skuId = dictionary["skuId"] as? Int
        time = dictionary["time"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if deliveryStatus != nil{
            dictionary["deliveryStatus"] = deliveryStatus
        }
        if desc != nil{
            dictionary["desc"] = desc
        }
        if id != nil{
            dictionary["id"] = id
        }
        if images != nil{
            dictionary["images"] = images
        }
        if name != nil{
            dictionary["name"] = name
        }
        if price != nil{
            dictionary["price"] = price
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if time != nil{
            dictionary["time"] = time
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        deliveryStatus = aDecoder.decodeObject(forKey: "deliveryStatus") as? Int
        desc = aDecoder.decodeObject(forKey: "desc") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        images = aDecoder.decodeObject(forKey: "images") as? [String]
        name = aDecoder.decodeObject(forKey: "name") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        time = aDecoder.decodeObject(forKey: "time") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if deliveryStatus != nil{
            aCoder.encode(deliveryStatus, forKey: "deliveryStatus")
        }
        if desc != nil{
            aCoder.encode(desc, forKey: "desc")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if images != nil{
            aCoder.encode(images, forKey: "images")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        
    }
}
