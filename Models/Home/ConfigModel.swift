//
//  ConfigModel.swift
//  CatchMe
//
//  Created by Zhang on 30/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ConfigModel : NSObject, NSCoding{
    
    var descriptionField : String!
    var key : String!
    var value : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        descriptionField = dictionary["description"] as? String
        key = dictionary["key"] as? String
        value = dictionary["value"] as? Bool
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
        if key != nil{
            dictionary["key"] = key
        }
        if value != nil{
            dictionary["value"] = value
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
        key = aDecoder.decodeObject(forKey: "key") as? String
        value = aDecoder.decodeObject(forKey: "value") as? Bool
        
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
        if key != nil{
            aCoder.encode(key, forKey: "key")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
        
    }
    
}
