//
//  TopWeeklyModel.swift
//  CatchMe
//
//  Created by Zhang on 28/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopWeeklyModel : NSObject, NSCoding{
    
    var firstDayOfWeek : Int!
    var gameStatistics : [GameStatistic]!
    var lastDayOfWeek : Int!
    var weekth : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        firstDayOfWeek = dictionary["firstDayOfWeek"] as? Int
        gameStatistics = [GameStatistic]()
        if let gameStatisticsArray = dictionary["gameStatistics"] as? [NSDictionary]{
            for dic in gameStatisticsArray{
                let value = GameStatistic(fromDictionary: dic)
                gameStatistics.append(value)
            }
        }
        lastDayOfWeek = dictionary["lastDayOfWeek"] as? Int
        weekth = dictionary["weekth"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if firstDayOfWeek != nil{
            dictionary["firstDayOfWeek"] = firstDayOfWeek
        }
        if gameStatistics != nil{
            var dictionaryElements = [NSDictionary]()
            for gameStatisticsElement in gameStatistics {
                dictionaryElements.append(gameStatisticsElement.toDictionary())
            }
            dictionary["gameStatistics"] = dictionaryElements
        }
        if lastDayOfWeek != nil{
            dictionary["lastDayOfWeek"] = lastDayOfWeek
        }
        if weekth != nil{
            dictionary["weekth"] = weekth
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        firstDayOfWeek = aDecoder.decodeObject(forKey: "firstDayOfWeek") as? Int
        gameStatistics = aDecoder.decodeObject(forKey: "gameStatistics") as? [GameStatistic]
        lastDayOfWeek = aDecoder.decodeObject(forKey: "lastDayOfWeek") as? Int
        weekth = aDecoder.decodeObject(forKey: "weekth") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if firstDayOfWeek != nil{
            aCoder.encode(firstDayOfWeek, forKey: "firstDayOfWeek")
        }
        if gameStatistics != nil{
            aCoder.encode(gameStatistics, forKey: "gameStatistics")
        }
        if lastDayOfWeek != nil{
            aCoder.encode(lastDayOfWeek, forKey: "lastDayOfWeek")
        }
        if weekth != nil{
            aCoder.encode(weekth, forKey: "weekth")
        }
        
    }
    
}

class GameStatistic : NSObject, NSCoding{
    
    var count : Int!
    var name : String!
    var photo : AnyObject!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        count = dictionary["count"] as? Int
        name = dictionary["name"] as? String
        photo = dictionary["photo"] as AnyObject
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if count != nil{
            dictionary["count"] = count
        }
        if name != nil{
            dictionary["name"] = name
        }
        if photo != nil{
            dictionary["photo"] = photo
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        count = aDecoder.decodeObject(forKey: "count") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        photo = aDecoder.decodeObject(forKey: "photo") as AnyObject
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if photo != nil{
            aCoder.encode(photo, forKey: "photo")
        }
        
    }
    
}
