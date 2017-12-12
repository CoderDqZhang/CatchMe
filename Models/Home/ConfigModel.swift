//
//  ConfigModel.swift
//  CatchMe
//
//  Created by Zhang on 30/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ConfigModel : NSObject, NSCoding{
    
    var isOnlineVersion : Bool!
    var musicName : String!
    
    static let shanreInstance = ConfigModel()
    
    override init() {
        super.init()
    }
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        isOnlineVersion = dictionary["isOnlineVersion"] as? Bool
        musicName = dictionary["musicName"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if isOnlineVersion != nil{
            dictionary["isOnlineVersion"] = isOnlineVersion
        }
        if musicName != nil{
            dictionary["musicName"] = musicName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isOnlineVersion = aDecoder.decodeObject(forKey: "isOnlineVersion") as? Bool
        musicName = aDecoder.decodeObject(forKey: "musicName") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isOnlineVersion != nil{
            aCoder.encode(isOnlineVersion, forKey: "isOnlineVersion")
        }
        if musicName != nil{
            aCoder.encode(musicName, forKey: "musicName")
        }
        
    }
    
}
