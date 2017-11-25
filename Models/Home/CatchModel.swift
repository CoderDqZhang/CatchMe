//
//  CatchModel.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CatchMeModel : NSObject, NSCoding{
    
    var currentPlayStatus : Int!
    var currentPlayerId : Int!
    var id : Int!
    var machineDTO : MachineDTO!
    var onlineUserList : [Int]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        currentPlayStatus = dictionary["currentPlayStatus"] as? Int
        currentPlayerId = dictionary["currentPlayerId"] as? Int
        id = dictionary["id"] as? Int
        if let machineDTOData = dictionary["machineDTO"] as? NSDictionary{
            machineDTO = MachineDTO(fromDictionary: machineDTOData)
        }
        onlineUserList = dictionary["onlineUserList"] as? [Int]
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if currentPlayStatus != nil{
            dictionary["currentPlayStatus"] = currentPlayStatus
        }
        if currentPlayerId != nil{
            dictionary["currentPlayerId"] = currentPlayerId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if machineDTO != nil{
            dictionary["machineDTO"] = machineDTO.toDictionary()
        }
        if onlineUserList != nil{
            dictionary["onlineUserList"] = onlineUserList
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentPlayStatus = aDecoder.decodeObject(forKey:"currentPlayStatus") as? Int
        currentPlayerId = aDecoder.decodeObject(forKey:"currentPlayerId") as? Int
        id = aDecoder.decodeObject(forKey:"id") as? Int
        machineDTO = aDecoder.decodeObject(forKey:"machineDTO") as? MachineDTO
        onlineUserList = aDecoder.decodeObject(forKey:"onlineUserList") as? [Int]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentPlayStatus != nil{
            aCoder.encode(currentPlayStatus, forKey: "currentPlayStatus")
        }
        if currentPlayerId != nil{
            aCoder.encode(currentPlayerId, forKey: "currentPlayerId")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if machineDTO != nil{
            aCoder.encode(machineDTO, forKey: "machineDTO")
        }
        if onlineUserList != nil{
            aCoder.encode(onlineUserList, forKey: "onlineUserList")
        }
        
    }
    
}

class MachineDTO : NSObject, NSCoding{
    
    var audiencePullAddressA : String!
    var audiencePullAddressB : String!
    var id : Int!
    var playerAccountId : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        audiencePullAddressA = dictionary["audiencePullAddressA"] as? String
        audiencePullAddressB = dictionary["audiencePullAddressB"] as? String
        id = dictionary["id"] as? Int
        playerAccountId = dictionary["playerAccountId"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if audiencePullAddressA != nil{
            dictionary["audiencePullAddressA"] = audiencePullAddressA
        }
        if audiencePullAddressB != nil{
            dictionary["audiencePullAddressB"] = audiencePullAddressB
        }
        if id != nil{
            dictionary["id"] = id
        }
        if playerAccountId != nil{
            dictionary["playerAccountId"] = playerAccountId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        audiencePullAddressA = aDecoder.decodeObject(forKey: "audiencePullAddressA") as? String
        audiencePullAddressB = aDecoder.decodeObject(forKey:"audiencePullAddressB") as? String
        id = aDecoder.decodeObject(forKey:"id") as? Int
        playerAccountId = aDecoder.decodeObject(forKey:"playerAccountId") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if audiencePullAddressA != nil{
            aCoder.encode(audiencePullAddressA, forKey: "audiencePullAddressA")
        }
        if audiencePullAddressB != nil{
            aCoder.encode(audiencePullAddressB, forKey: "audiencePullAddressB")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if playerAccountId != nil{
            aCoder.encode(playerAccountId, forKey: "playerAccountId")
        }
        
    }
}

class HeaderModel : NSObject, NSCoding{
    
    var currentPlayStatus : Int!
    var currentPlayerId : Int!
    var userList : [Int]!
    var headerModel : HeaderModel!
    var code : Int!
    var message : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        currentPlayStatus = dictionary["currentPlayStatus"] as? Int
        currentPlayerId = dictionary["currentPlayerId"] as? Int
        userList = dictionary["userList"] as? [Int]
        if let headerModelData = dictionary["HeaderModel"] as? NSDictionary{
            headerModel = HeaderModel(fromDictionary: headerModelData)
        }
        code = dictionary["code"] as? Int
        message = dictionary["message"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if currentPlayStatus != nil{
            dictionary["currentPlayStatus"] = currentPlayStatus
        }
        if currentPlayerId != nil{
            dictionary["currentPlayerId"] = currentPlayerId
        }
        if userList != nil{
            dictionary["userList"] = userList
        }
        if headerModel != nil{
            dictionary["HeaderModel"] = headerModel.toDictionary()
        }
        if code != nil{
            dictionary["code"] = code
        }
        if message != nil{
            dictionary["message"] = message
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentPlayStatus = aDecoder.decodeObject(forKey: "currentPlayStatus") as? Int
        currentPlayerId = aDecoder.decodeObject(forKey: "currentPlayerId") as? Int
        userList = aDecoder.decodeObject(forKey: "userList") as? [Int]
        headerModel = aDecoder.decodeObject(forKey: "HeaderModel") as? HeaderModel
        code = aDecoder.decodeObject(forKey: "code") as? Int
        message = aDecoder.decodeObject(forKey: "message") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentPlayStatus != nil{
            aCoder.encode(currentPlayStatus, forKey: "currentPlayStatus")
        }
        if currentPlayerId != nil{
            aCoder.encode(currentPlayerId, forKey: "currentPlayerId")
        }
        if userList != nil{
            aCoder.encode(userList, forKey: "userList")
        }
        if headerModel != nil{
            aCoder.encode(headerModel, forKey: "HeaderModel")
        }
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        
    }
    
}
