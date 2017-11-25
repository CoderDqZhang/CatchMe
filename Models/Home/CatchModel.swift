//
//  CatchModel.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CatchMeModel : NSObject, NSCoding{
    
    var id : Int!
    var machineDTO : MachineDTO!
    var onlineUserList : [Int]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
        machineDTO = aDecoder.decodeObject(forKey: "machineDTO") as? MachineDTO
        onlineUserList = aDecoder.decodeObject(forKey: "onlineUserList") as? [Int]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
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
    
    var cameraDTOList : [CameraDTOList]!
    var id : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        cameraDTOList = [CameraDTOList]()
        if let cameraDTOListArray = dictionary["cameraDTOList"] as? [NSDictionary]{
            for dic in cameraDTOListArray{
                let value = CameraDTOList(fromDictionary: dic)
                cameraDTOList.append(value)
            }
        }
        id = dictionary["id"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if cameraDTOList != nil{
            var dictionaryElements = [NSDictionary]()
            for cameraDTOListElement in cameraDTOList {
                dictionaryElements.append(cameraDTOListElement.toDictionary())
            }
            dictionary["cameraDTOList"] = dictionaryElements
        }
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cameraDTOList = aDecoder.decodeObject(forKey: "cameraDTOList") as? [CameraDTOList]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cameraDTOList != nil{
            aCoder.encode(cameraDTOList, forKey: "cameraDTOList")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        
    }
    
}

class CameraDTOList : NSObject, NSCoding{
    
    var id : Int!
    var neteaseAccountId : String!
    var neteaseChannelId : String!
    var neteasePullAddress : String!
    var type : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int
        neteaseAccountId = dictionary["neteaseAccountId"] as? String
        neteaseChannelId = dictionary["neteaseChannelId"] as? String
        neteasePullAddress = dictionary["neteasePullAddress"] as? String
        type = dictionary["type"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if id != nil{
            dictionary["id"] = id
        }
        if neteaseAccountId != nil{
            dictionary["neteaseAccountId"] = neteaseAccountId
        }
        if neteaseChannelId != nil{
            dictionary["neteaseChannelId"] = neteaseChannelId
        }
        if neteasePullAddress != nil{
            dictionary["neteasePullAddress"] = neteasePullAddress
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
        neteaseAccountId = aDecoder.decodeObject(forKey: "neteaseAccountId") as? String
        neteaseChannelId = aDecoder.decodeObject(forKey: "neteaseChannelId") as? String
        neteasePullAddress = aDecoder.decodeObject(forKey: "neteasePullAddress") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if neteaseAccountId != nil{
            aCoder.encode(neteaseAccountId, forKey: "neteaseAccountId")
        }
        if neteaseChannelId != nil{
            aCoder.encode(neteaseChannelId, forKey: "neteaseChannelId")
        }
        if neteasePullAddress != nil{
            aCoder.encode(neteasePullAddress, forKey: "neteasePullAddress")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        
    }
    
}
