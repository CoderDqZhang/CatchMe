//
//  HomeLables.swift
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class HomeLabels : NSObject, NSCoding{
    
    var data : [Labels]!
    var limit : Int!
    var offset : Int!
    var total : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        data = [Labels]()
        if let dataArray = dictionary["data"] as? [NSDictionary]{
            for dic in dataArray{
                let value = Labels(fromDictionary: dic)
                data.append(value)
            }
        }
        limit = dictionary["limit"] as? Int
        offset = dictionary["offset"] as? Int
        total = dictionary["total"] as? Int
    }
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if data != nil{
            var dictionaryElements = [NSDictionary]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        if limit != nil{
            dictionary["limit"] = limit
        }
        if offset != nil{
            dictionary["offset"] = offset
        }
        if total != nil{
            dictionary["total"] = total
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [Labels]
        limit = aDecoder.decodeObject(forKey: "limit") as? Int
        offset = aDecoder.decodeObject(forKey: "offset") as? Int
        total = aDecoder.decodeObject(forKey: "total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if limit != nil{
            aCoder.encode(limit, forKey: "limit")
        }
        if offset != nil{
            aCoder.encode(offset, forKey: "offset")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        
    }
    
}

class Labels : NSObject, NSCoding{
    
    var freeStatus : Int!
    var id : Int!
    var ownStatus : Int!
    var skuImageAddress : String!
    var price : Int!
    var skuId : Int!
    var skuName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        freeStatus = dictionary["freeStatus"] as? Int
        id = dictionary["id"] as? Int
        ownStatus = dictionary["ownStatus"] as? Int
        price = dictionary["price"] as? Int
        skuId = dictionary["skuId"] as? Int
        skuName = dictionary["skuName"] as? String
        skuImageAddress = dictionary["skuImageAddress"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if freeStatus != nil{
            dictionary["freeStatus"] = freeStatus
        }
        if id != nil{
            dictionary["id"] = id
        }
        if ownStatus != nil{
            dictionary["ownStatus"] = ownStatus
        }
        if price != nil{
            dictionary["price"] = price
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if skuName != nil{
            dictionary["skuName"] = skuName
        }
        if skuImageAddress != nil{
            dictionary["skuImageAddress"] = skuName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        freeStatus = aDecoder.decodeObject(forKey: "freeStatus") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        ownStatus = aDecoder.decodeObject(forKey: "ownStatus") as? Int
        price = aDecoder.decodeObject(forKey: "price") as? Int
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        skuName = aDecoder.decodeObject(forKey: "skuName") as? String
        skuImageAddress = aDecoder.decodeObject(forKey: "skuImageAddress") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder) 
    {
        if freeStatus != nil{
            aCoder.encode(freeStatus, forKey: "freeStatus")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if ownStatus != nil{
            aCoder.encode(ownStatus, forKey: "ownStatus")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if skuName != nil{
            aCoder.encode(skuName, forKey: "skuName")
        }
        if skuImageAddress != nil{
            aCoder.encode(skuImageAddress, forKey: "skuImageAddress")
        }
        
    }
    
}
