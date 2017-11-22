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
    
    var free : Int!
    var hadSku : Int!
    var imageAddress : String!
    var labels : [String]!
    var skuId : Int!
    var skuName : String!
    var timeCost : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        free = dictionary["free"] as? Int
        hadSku = dictionary["hadSku"] as? Int
        imageAddress = dictionary["imageAddress"] as? String
        labels = dictionary["labels"] as? [String]
        skuId = dictionary["skuId"] as? Int
        skuName = dictionary["skuName"] as? String
        timeCost = dictionary["timeCost"] as? Int
    }
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if free != nil{
            dictionary["free"] = free
        }
        if hadSku != nil{
            dictionary["hadSku"] = hadSku
        }
        if imageAddress != nil{
            dictionary["imageAddress"] = imageAddress
        }
        if labels != nil{
            dictionary["labels"] = labels
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if skuName != nil{
            dictionary["skuName"] = skuName
        }
        if timeCost != nil{
            dictionary["timeCost"] = timeCost
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        free = aDecoder.decodeObject(forKey: "free") as? Int
        hadSku = aDecoder.decodeObject(forKey: "hadSku") as? Int
        imageAddress = aDecoder.decodeObject(forKey: "imageAddress") as? String
        labels = aDecoder.decodeObject(forKey: "labels") as? [String]
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        skuName = aDecoder.decodeObject(forKey: "skuName") as? String
        timeCost = aDecoder.decodeObject(forKey: "timeCost") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if free != nil{
            aCoder.encode(free, forKey: "free")
        }
        if hadSku != nil{
            aCoder.encode(hadSku, forKey: "hadSku")
        }
        if imageAddress != nil{
            aCoder.encode(imageAddress, forKey: "imageAddress")
        }
        if labels != nil{
            aCoder.encode(labels, forKey: "labels")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if skuName != nil{
            aCoder.encode(skuName, forKey: "skuName")
        }
        if timeCost != nil{
            aCoder.encode(timeCost, forKey: "timeCost")
        }
        
    }
    
}
