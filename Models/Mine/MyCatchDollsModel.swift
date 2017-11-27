//
//  MyCatchDollsModel.swift
//  CatchMe
//
//  Created by Zhang on 27/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyCatchDollsModel : NSObject, NSCoding{
    
    var data : [Doll]!
    var limit : Int!
    var offset : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        data = [Doll]()
        if let dataArray = dictionary["data"] as? [NSDictionary]{
            for dic in dataArray{
                let value = Doll(fromDictionary: dic)
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
        data = aDecoder.decodeObject(forKey: "data") as? [Doll]
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

class Doll : NSObject, NSCoding{
    
    var catchdollId : Int!
    var date : String!
    var imgAddress : String!
    var skuName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        catchdollId = dictionary["catchdollId"] as? Int
        date = dictionary["date"] as? String
        imgAddress = dictionary["imgAddress"] as? String
        skuName = dictionary["skuName"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if catchdollId != nil{
            dictionary["catchdollId"] = catchdollId
        }
        if date != nil{
            dictionary["date"] = date
        }
        if imgAddress != nil{
            dictionary["imgAddress"] = imgAddress
        }
        if skuName != nil{
            dictionary["skuName"] = skuName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        catchdollId = aDecoder.decodeObject(forKey: "catchdollId") as? Int
        date = aDecoder.decodeObject(forKey: "date") as? String
        imgAddress = aDecoder.decodeObject(forKey: "imgAddress") as? String
        skuName = aDecoder.decodeObject(forKey: "skuName") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if catchdollId != nil{
            aCoder.encode(catchdollId, forKey: "catchdollId")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if imgAddress != nil{
            aCoder.encode(imgAddress, forKey: "imgAddress")
        }
        if skuName != nil{
            aCoder.encode(skuName, forKey: "skuName")
        }
        
    }
    
}
