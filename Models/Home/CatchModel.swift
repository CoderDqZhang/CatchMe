//
//  CatchModel.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CatchMeModel : NSObject, NSCoding{
    
    var currentPlayerDTO : BasicUserDTO?
    var currentPlayStatus : Int!
    var id : Int!
    var machineDTO : MachineDTO!
    var onlineUserList : [Int]!
    var price : Int!
    var skuId : Int!
    var imageAddress : String!
    var name : String!
    var skuSubId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let basicUserDTOData = dictionary["currentPlayerDTO"] as? NSDictionary{
            currentPlayerDTO = BasicUserDTO(fromDictionary: basicUserDTOData)
        }
        currentPlayStatus = dictionary["currentPlayStatus"] as? Int
        id = dictionary["id"] as? Int
        if let machineDTOData = dictionary["machineDTO"] as? NSDictionary{
            machineDTO = MachineDTO(fromDictionary: machineDTOData)
        }
        onlineUserList = dictionary["onlineUserList"] as? [Int]
        price = dictionary["price"] as? Int
        skuId = dictionary["skuId"] as? Int
        imageAddress = dictionary["imageAddress"] as? String
        name = dictionary["name"] as? String
        skuSubId = dictionary["skuSubId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if currentPlayerDTO != nil{
            dictionary["currentPlayerDTO"] = currentPlayerDTO?.toDictionary()
        }
        if currentPlayStatus != nil{
            dictionary["currentPlayStatus"] = currentPlayStatus
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
        if price != nil{
            dictionary["price"] = price
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if imageAddress != nil{
            dictionary["imageAddress"] = imageAddress
        }
        if name != nil{
            dictionary["name"] = name
        }
        if skuSubId != nil{
            dictionary["skuSubId"] = skuSubId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentPlayerDTO = aDecoder.decodeObject(forKey: "currentPlayerDTO") as? BasicUserDTO
        currentPlayStatus = aDecoder.decodeObject(forKey: "currentPlayStatus") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        machineDTO = aDecoder.decodeObject(forKey: "machineDTO") as? MachineDTO
        onlineUserList = aDecoder.decodeObject(forKey: "onlineUserList") as? [Int]
        price = aDecoder.decodeObject(forKey: "price") as? Int
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        imageAddress = aDecoder.decodeObject(forKey: "imageAddress") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        skuSubId = aDecoder.decodeObject(forKey: "skuSubId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentPlayerDTO != nil{
            aCoder.encode(currentPlayerDTO, forKey: "currentPlayerDTO")
        }
        if currentPlayStatus != nil{
            aCoder.encode(currentPlayStatus, forKey: "currentPlayStatus")
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
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if imageAddress != nil{
            aCoder.encode(imageAddress, forKey: "imageAddress")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if skuSubId != nil{
            aCoder.encode(skuSubId, forKey: "skuSubId")
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
        audiencePullAddressB = aDecoder.decodeObject(forKey: "audiencePullAddressB") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        playerAccountId = aDecoder.decodeObject(forKey: "playerAccountId") as? String
        
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

class BasicUserDTO : NSObject, NSCoding{
    
    var coinAmount : Int!
    var gender : Int!
    var id : Int!
    var photo : String!
    var telephone : String!
    var userName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        coinAmount = dictionary["coinAmount"] as? Int
        gender = dictionary["gender"] as? Int
        id = dictionary["id"] as? Int
        photo = dictionary["photo"] as? String
        telephone = dictionary["telephone"] as? String
        userName = dictionary["userName"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if coinAmount != nil{
            dictionary["coinAmount"] = coinAmount
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if id != nil{
            dictionary["id"] = id
        }
        if photo != nil{
            dictionary["photo"] = photo
        }
        if telephone != nil{
            dictionary["telephone"] = telephone
        }
        if userName != nil{
            dictionary["userName"] = userName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        coinAmount = aDecoder.decodeObject(forKey: "coinAmount") as? Int
        gender = aDecoder.decodeObject(forKey: "gender") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        photo = aDecoder.decodeObject(forKey: "photo") as? String
        telephone = aDecoder.decodeObject(forKey: "telephone") as? String
        userName = aDecoder.decodeObject(forKey: "userName") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if coinAmount != nil{
            aCoder.encode(coinAmount, forKey: "coinAmount")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if photo != nil{
            aCoder.encode(photo, forKey: "photo")
        }
        if telephone != nil{
            aCoder.encode(telephone, forKey: "telephone")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "userName")
        }
        
    }
    
}

class HeartModel : NSObject, NSCoding{
    
    var currentPlayerDTO : BasicUserDTO?
    var currentPlayStatus : Int!
    var currentPlayerId : AnyObject!
    var userList : [Int]!
    var balance : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        if let basicUserDTOData = dictionary["currentPlayerDTO"] as? NSDictionary{
            currentPlayerDTO = BasicUserDTO(fromDictionary: basicUserDTOData)
        }
        currentPlayStatus = dictionary["currentPlayStatus"] as? Int
        currentPlayerId = dictionary["currentPlayerId"] as AnyObject
        userList = dictionary["userList"] as? [Int]
        balance = dictionary["balance"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if currentPlayerDTO != nil{
            dictionary["currentPlayerDTO"] = currentPlayerDTO?.toDictionary()
        }
        if balance != nil{
            dictionary["balance"] = balance
        }
        if currentPlayStatus != nil{
            dictionary["currentPlayStatus"] = currentPlayStatus
        }
        if currentPlayerId != nil{
            dictionary["currentPlayerId"] = currentPlayerId
        }
        if userList != nil{
            dictionary["userList"] = userList
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentPlayerDTO = aDecoder.decodeObject(forKey: "currentPlayerDTO") as? BasicUserDTO
        currentPlayStatus = aDecoder.decodeObject(forKey: "currentPlayStatus") as? Int
        currentPlayerId = aDecoder.decodeObject(forKey: "currentPlayerId") as AnyObject
        userList = aDecoder.decodeObject(forKey: "userList") as? [Int]
        balance = aDecoder.decodeObject(forKey: "balance") as? Int
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentPlayerDTO != nil{
            aCoder.encode(currentPlayerDTO, forKey: "currentPlayerDTO")
        }
        if currentPlayStatus != nil{
            aCoder.encode(currentPlayStatus, forKey: "currentPlayStatus")
        }
        if currentPlayerId != nil{
            aCoder.encode(currentPlayerId, forKey: "currentPlayerId")
        }
        if userList != nil{
            aCoder.encode(userList, forKey: "userList")
        }
        if balance != nil{
            aCoder.encode(balance, forKey: "balance")
        }
        
    }
    
}

class PrepareGameModel : NSObject, NSCoding{
    
    var gameId : Int!
    var maxTime : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        gameId = dictionary["gameId"] as? Int
        maxTime = dictionary["maxTime"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if gameId != nil{
            dictionary["gameId"] = gameId
        }
        if maxTime != nil{
            dictionary["maxTime"] = maxTime
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        gameId = aDecoder.decodeObject(forKey: "gameId") as? Int
        maxTime = aDecoder.decodeObject(forKey: "maxTime") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if gameId != nil{
            aCoder.encode(gameId, forKey: "gameId")
        }
        if maxTime != nil{
            aCoder.encode(maxTime, forKey: "maxTime")
        }
        
    }
    
}

class GameStatusModel : NSObject, NSCoding{
    
    var color : Int!
    var id : Int!
    var imageAddress : String!
    var machineId : Int!
    var price : Int!
    var roomId : Int!
    var skuId : Int!
    var name : String!
    var skuSubId : Int!
    var status : Int!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        color = dictionary["color"] as? Int
        id = dictionary["id"] as? Int
        imageAddress = dictionary["imageAddress"] as? String
        machineId = dictionary["machineId"] as? Int
        price = dictionary["price"] as? Int
        roomId = dictionary["roomId"] as? Int
        skuId = dictionary["skuId"] as? Int
        name = dictionary["name"] as? String
        skuSubId = dictionary["skuSubId"] as? Int
        status = dictionary["status"] as? Int
        userId = dictionary["userId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if color != nil{
            dictionary["color"] = color
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imageAddress != nil{
            dictionary["imageAddress"] = imageAddress
        }
        if machineId != nil{
            dictionary["machineId"] = machineId
        }
        if price != nil{
            dictionary["price"] = price
        }
        if roomId != nil{
            dictionary["roomId"] = roomId
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if name != nil{
            dictionary["name"] = name
        }
        if skuSubId != nil{
            dictionary["skuSubId"] = skuSubId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        color = aDecoder.decodeObject(forKey: "color") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imageAddress = aDecoder.decodeObject(forKey: "imageAddress") as? String
        machineId = aDecoder.decodeObject(forKey: "machineId") as? Int
        price = aDecoder.decodeObject(forKey: "price") as? Int
        roomId = aDecoder.decodeObject(forKey: "roomId") as? Int
        skuId = aDecoder.decodeObject(forKey: "skuId") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        skuSubId = aDecoder.decodeObject(forKey: "skuSubId") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if color != nil{
            aCoder.encode(color, forKey: "color")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imageAddress != nil{
            aCoder.encode(imageAddress, forKey: "imageAddress")
        }
        if machineId != nil{
            aCoder.encode(machineId, forKey: "machineId")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if roomId != nil{
            aCoder.encode(roomId, forKey: "roomId")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if skuSubId != nil{
            aCoder.encode(skuSubId, forKey: "skuSubId")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}

class PlayGameAgain : NSObject, NSCoding{
    
    var gameId : Int!
    var imageAddress : AnyObject!
    var maxTime : Int!
    var price : AnyObject!
    var roomDetailDTO : AnyObject!
    var skuId : AnyObject!
    var name : AnyObject!
    var skuSubId : AnyObject!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        gameId = dictionary["gameId"] as? Int
        imageAddress = dictionary["imageAddress"] as AnyObject
        maxTime = dictionary["maxTime"] as? Int
        price = dictionary["price"] as AnyObject
        roomDetailDTO = dictionary["roomDetailDTO"] as AnyObject
        skuId = dictionary["skuId"] as AnyObject
        name = dictionary["name"] as AnyObject
        skuSubId = dictionary["skuSubId"] as AnyObject
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if gameId != nil{
            dictionary["gameId"] = gameId
        }
        if imageAddress != nil{
            dictionary["imageAddress"] = imageAddress
        }
        if maxTime != nil{
            dictionary["maxTime"] = maxTime
        }
        if price != nil{
            dictionary["price"] = price
        }
        if roomDetailDTO != nil{
            dictionary["roomDetailDTO"] = roomDetailDTO
        }
        if skuId != nil{
            dictionary["skuId"] = skuId
        }
        if name != nil{
            dictionary["name"] = name
        }
        if skuSubId != nil{
            dictionary["skuSubId"] = skuSubId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        gameId = aDecoder.decodeObject(forKey:"gameId") as? Int
        imageAddress = aDecoder.decodeObject(forKey:"imageAddress") as AnyObject
        maxTime = aDecoder.decodeObject(forKey:"maxTime") as? Int
        price = aDecoder.decodeObject(forKey:"price") as AnyObject
        roomDetailDTO = aDecoder.decodeObject(forKey:"roomDetailDTO") as AnyObject
        skuId = aDecoder.decodeObject(forKey:"skuId") as AnyObject
        name = aDecoder.decodeObject(forKey:"name") as AnyObject
        skuSubId = aDecoder.decodeObject(forKey: "skuSubId") as AnyObject
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if gameId != nil{
            aCoder.encode(gameId, forKey: "gameId")
        }
        if imageAddress != nil{
            aCoder.encode(imageAddress, forKey: "imageAddress")
        }
        if maxTime != nil{
            aCoder.encode(maxTime, forKey: "maxTime")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if roomDetailDTO != nil{
            aCoder.encode(roomDetailDTO, forKey: "roomDetailDTO")
        }
        if skuId != nil{
            aCoder.encode(skuId, forKey: "skuId")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if skuSubId != nil{
            aCoder.encode(skuSubId, forKey: "skuSubId")
        }
        
    }
    
}
