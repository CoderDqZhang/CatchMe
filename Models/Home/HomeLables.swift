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
    var imageAddress : String!
    var price : Int!
    var skuId : Int!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        freeStatus = dictionary["freeStatus"] as? Int
        id = dictionary["id"] as? Int
        ownStatus = dictionary["ownStatus"] as? Int
        price = dictionary["price"] as? Int
        skuId = dictionary["skuId"] as? Int
        name = dictionary["name"] as? String
        imageAddress = dictionary["imageAddress"] as? String
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
        if name != nil{
            dictionary["name"] = name
        }
        if imageAddress != nil{
            dictionary["imageAddress"] = name
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
        name = aDecoder.decodeObject(forKey: "name") as? String
        imageAddress = aDecoder.decodeObject(forKey: "imageAddress") as? String
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
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if imageAddress != nil{
            aCoder.encode(imageAddress, forKey: "imageAddress")
        }
        
    }
    
}

class BannerModel : NSObject, NSCoding{
    
    var bannerAddress : String!
    var id : Int!
    var linkAddress : String!
    var roomId : AnyObject!
    var sequence : Int!
    var status : Int!
    var title : String!
    var type : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        bannerAddress = dictionary["bannerAddress"] as? String
        id = dictionary["id"] as? Int
        linkAddress = dictionary["linkAddress"] as? String
        roomId = dictionary["roomId"] as AnyObject
        sequence = dictionary["sequence"] as? Int
        status = dictionary["status"] as? Int
        title = dictionary["title"] as? String
        type = dictionary["type"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if bannerAddress != nil{
            dictionary["bannerAddress"] = bannerAddress
        }
        if id != nil{
            dictionary["id"] = id
        }
        if linkAddress != nil{
            dictionary["linkAddress"] = linkAddress
        }
        if roomId != nil{
            dictionary["roomId"] = roomId
        }
        if sequence != nil{
            dictionary["sequence"] = sequence
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bannerAddress = aDecoder.decodeObject(forKey: "bannerAddress") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        linkAddress = aDecoder.decodeObject(forKey: "linkAddress") as? String
        roomId = aDecoder.decodeObject(forKey: "roomId") as AnyObject
        sequence = aDecoder.decodeObject(forKey: "sequence") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bannerAddress != nil{
            aCoder.encode(bannerAddress, forKey: "bannerAddress")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if linkAddress != nil{
            aCoder.encode(linkAddress, forKey: "linkAddress")
        }
        if roomId != nil{
            aCoder.encode(roomId, forKey: "roomId")
        }
        if sequence != nil{
            aCoder.encode(sequence, forKey: "sequence")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
    }
}

class DollsDetailModel : NSObject, NSCoding{
    
    var desc : String!
    var flag : Int!
    var id : Int!
    var images : [String]!
    var name : String!
    var price : Int!
    var shareMessage : AnyObject!
    var skuId : Int!
    var time : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        desc = dictionary["desc"] as? String
        flag = dictionary["flag"] as? Int
        id = dictionary["id"] as? Int
        images = dictionary["images"] as? [String]
        name = dictionary["name"] as? String
        price = dictionary["price"] as? Int
        shareMessage = dictionary["shareMessage"] as? AnyObject
        skuId = dictionary["skuId"] as? Int
        time = dictionary["time"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if desc != nil{
            dictionary["desc"] = desc
        }
        if flag != nil{
            dictionary["flag"] = flag
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
        if shareMessage != nil{
            dictionary["shareMessage"] = shareMessage
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
        desc = aDecoder.decodeObject(forKey: "desc") as? String
        flag = aDecoder.decodeObject(forKey: "flag") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        images = aDecoder.decodeObject(forKey: "images") as? [String]
        name = aDecoder.decodeObject(forKey: "name") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        shareMessage = aDecoder.decodeObject(forKey: "shareMessage") as? AnyObject
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        time = aDecoder.decodeObject(forKey: "time") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if desc != nil{
            aCoder.encode(desc, forKey: "desc")
        }
        if flag != nil{
            aCoder.encode(flag, forKey: "flag")
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
        if shareMessage != nil{
            aCoder.encode(shareMessage, forKey: "shareMessage")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        
    }
    
}
