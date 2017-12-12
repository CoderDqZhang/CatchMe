//
//  ShareModel.swift
//  CatchMe
//
//  Created by Zhang on 13/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SessionShareModel : NSObject, NSCoding{
    
    var descriptionField : String!
    var id : Int!
    var name : String!
    var status : Int!
    var thumbnailAddress : String!
    var title : String!
    var type : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        status = dictionary["status"] as? Int
        thumbnailAddress = dictionary["thumbnailAddress"] as? String
        title = dictionary["title"] as? String
        type = dictionary["type"] as? Int
        url = dictionary["url"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if status != nil{
            dictionary["status"] = status
        }
        if thumbnailAddress != nil{
            dictionary["thumbnailAddress"] = thumbnailAddress
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey:  "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        thumbnailAddress = aDecoder.decodeObject(forKey: "thumbnailAddress") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        url = aDecoder.decodeObject(forKey: "url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if thumbnailAddress != nil{
            aCoder.encode(thumbnailAddress, forKey: "thumbnailAddress")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        
    }
    
}
