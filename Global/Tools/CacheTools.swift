//
//  CacheTools.swift
//  CatchMe
//
//  Created by Zhang on 30/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CacheTools: NSObject {

}

let kEncodedObjectPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
let kEncodeUserCachesDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String

class SaveImageTools{
    
    fileprivate init(){}
    
    static let sharedInstance = SaveImageTools()
    
    func getCachesDirectoryUserInfoDocumetPathDocument(_ user:String, document:String) ->String? {
        let manager = FileManager.default
        let path = (kEncodeUserCachesDirectory + "/\(user)") + "/\(document)"
        if !manager.fileExists(atPath: path) {
            do {
                try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return path
            } catch {
                print("创建失败")
                return nil
            }
        }else{
            return path
        }
    }
    
    func getCachesDirectoryUserInfoSmallDocumetPathDocument(_ user:String, document:String) ->String? {
        let manager = FileManager.default
        let path = (kEncodeUserCachesDirectory + "/\(user)") + "/\(document)"  + "/Small/"
        if !manager.fileExists(atPath: path) {
            do {
                try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return path
            } catch {
                print("创建失败")
                return nil
            }
        }else{
            return path
        }
    }
    
    
    func saveImage(_ name:String, image:UIImage, path:String) -> Bool {
        if UserInfoModel.isLoggedIn() {
            let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path)
            if saveFilePath == nil {
                return false
            }
            let saveName = saveFilePath?.appendingFormat("/\(name)")
            let imageData = UIImagePNGRepresentation(image)
            _ = self.saveSmallImage(name, image: image, path: path)
            do {
                try imageData?.write(to: URL.init(fileURLWithPath: saveName!), options: .atomic)
                return true
            } catch  {
                return false
            }
        }else{
            let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("Public", document: path)
            if saveFilePath == nil {
                return false
            }
            let saveName = (saveFilePath)! + "/\(name)"
            let imageData = UIImagePNGRepresentation(image)
            _ = self.saveSmallImage(name, image: image, path: path)
            return ((try? imageData?.write(to: URL(fileURLWithPath: saveName), options: [.atomic])) != nil)
        }
    }
    
    func saveSmallImage(_ name:String, image:UIImage, path:String) -> Bool {
        if UserInfoModel.isLoggedIn() {
            let saveFilePath = self.getCachesDirectoryUserInfoSmallDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path)
            if saveFilePath == nil {
                return false
            }
            let saveName = saveFilePath?.appendingFormat("\(name)")
            let imageData = UIImageJPEGRepresentation(image, 0.2)
            do {
                try imageData?.write(to: URL.init(fileURLWithPath: saveName!), options: .atomic)
                return true
            } catch  {
                return false
            }
        }else{
            let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("Public", document: path)
            if saveFilePath == nil {
                return false
            }
            let saveName = (saveFilePath)! + "/\(name)"
            let imageData = UIImageJPEGRepresentation(image, 0.2)
            return ((try? imageData?.write(to: URL(fileURLWithPath: saveName), options: [.atomic])) != nil)
        }
    }
    
    func LoadImage(_ name:String, path:String, isSmall:Bool) -> UIImage? {
        if UserInfoModel.isLoggedIn() {
            let saveFilePath = isSmall ? self.getCachesDirectoryUserInfoSmallDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path) : self.getCachesDirectoryUserInfoDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path)
            if saveFilePath == nil {
                return nil
            }
            let saveName = saveFilePath?.appendingFormat("/\(name)")
            do {
                let data = try Data.init(contentsOf: URL.init(fileURLWithPath: saveName!), options: Data.ReadingOptions.dataReadingMapped)
                return UIImage.init(data: data)
            } catch  {
                return nil
            }
        }else{
            let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("Public", document: path)
            if saveFilePath == nil {
                return nil
            }
            let saveName = (saveFilePath)! + "/\(name)"
            let data = try? Data.init(contentsOf: URL(fileURLWithPath: saveName))
            if data == nil {
                return nil
            }
            return UIImage.init(data: data!)
        }
    }
    
    func getCachesDirectory(_ name:String, path:String, isSmall:Bool) -> String {
        if UserInfoModel.isLoggedIn() {
            let saveFilePath = isSmall ? self.getCachesDirectoryUserInfoSmallDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path) : self.getCachesDirectoryUserInfoDocumetPathDocument(UserInfoModel.shareInstance().telephone, document: path)
            if saveFilePath == nil {
                return ""
            }
            let saveName = saveFilePath?.appendingFormat("/\(name)")
            return saveName!
        }else{
            let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("Public", document: path)
            if saveFilePath == nil {
                return ""
            }
            let saveName = (saveFilePath)! + "/\(name)"
            return saveName
        }
    }
}

