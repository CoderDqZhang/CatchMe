//
//  UserInfoModel.m
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

#import "UserInfoModel.h"

NSString *const kUserInfoGender = @"gender";
NSString *const kUserInfoIdField = @"id";
NSString *const kUserInfoPhoto = @"photo";
NSString *const kUserInfoRegisterType = @"registerType";
NSString *const kUserInfoShareCode = @"shareCode";
NSString *const kUserInfoShareNum = @"shareNum";
NSString *const kUserInfoShareStatus = @"shareStatus";
NSString *const kUserInfoTelephone = @"telephone";
NSString *const kUserInfoUserName = @"userName";
NSString *const kUserInfoWechatOpenid = @"wechatOpenid";

@interface UserInfoModel ()

@end

static UserInfoModel *_instance = nil;

@implementation UserInfoModel
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
        if ([UserInfoModel findAll].count > 0 ) {
            _instance =  [UserInfoModel findFirstByCriteria:[NSString stringWithFormat:@" where telephone = '%@'",object]];
        }else{
            _instance = [[UserInfoModel alloc] init];
        }
    });
    return _instance;
}

    
-(NSDictionary *)toDictionary
    {
        NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
        dictionary[kUserInfoGender] = @(self.gender);
        dictionary[kUserInfoIdField] = @(self.idField);
        if(self.photo != nil){
            dictionary[kUserInfoPhoto] = self.photo;
        }
        if(self.registerType != nil){
            dictionary[kUserInfoRegisterType] = self.registerType;
        }
        if(self.shareCode != nil){
            dictionary[kUserInfoShareCode] = self.shareCode;
        }
        if(self.shareNum != nil){
            dictionary[kUserInfoShareNum] = self.shareNum;
        }
        if(self.shareStatus != nil){
            dictionary[kUserInfoShareStatus] = self.shareStatus;
        }
        if(self.telephone != nil){
            dictionary[kUserInfoTelephone] = self.telephone;
        }
        if(self.userName != nil){
            dictionary[kUserInfoUserName] = self.userName;
        }
        if(self.wechatOpenid != nil){
            dictionary[kUserInfoWechatOpenid] = self.wechatOpenid;
        }
        return dictionary;
        
    }
    
    /**
     * Implementation of NSCoding encoding method
     */
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
- (void)encodeWithCoder:(NSCoder *)aCoder
    {
        [aCoder encodeObject:@(self.gender) forKey:kUserInfoGender];    [aCoder encodeObject:@(self.idField) forKey:kUserInfoIdField];    if(self.photo != nil){
            [aCoder encodeObject:self.photo forKey:kUserInfoPhoto];
        }
        if(self.registerType != nil){
            [aCoder encodeObject:self.registerType forKey:kUserInfoRegisterType];
        }
        if(self.shareCode != nil){
            [aCoder encodeObject:self.shareCode forKey:kUserInfoShareCode];
        }
        if(self.shareNum != nil){
            [aCoder encodeObject:self.shareNum forKey:kUserInfoShareNum];
        }
        if(self.shareStatus != nil){
            [aCoder encodeObject:self.shareStatus forKey:kUserInfoShareStatus];
        }
        if(self.telephone != nil){
            [aCoder encodeObject:self.telephone forKey:kUserInfoTelephone];
        }
        if(self.userName != nil){
            [aCoder encodeObject:self.userName forKey:kUserInfoUserName];
        }
        if(self.wechatOpenid != nil){
            [aCoder encodeObject:self.wechatOpenid forKey:kUserInfoWechatOpenid];
        }
        
    }
    
    /**
     * Implementation of NSCoding initWithCoder: method
     */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
    {
        self = [super init];
        self.gender = [[aDecoder decodeObjectForKey:kUserInfoGender] integerValue];
        self.idField = [[aDecoder decodeObjectForKey:kUserInfoIdField] integerValue];
        self.photo = [aDecoder decodeObjectForKey:kUserInfoPhoto];
        self.registerType = [aDecoder decodeObjectForKey:kUserInfoRegisterType];
        self.shareCode = [aDecoder decodeObjectForKey:kUserInfoShareCode];
        self.shareNum = [aDecoder decodeObjectForKey:kUserInfoShareNum];
        self.shareStatus = [aDecoder decodeObjectForKey:kUserInfoShareStatus];
        self.telephone = [aDecoder decodeObjectForKey:kUserInfoTelephone];
        self.userName = [aDecoder decodeObjectForKey:kUserInfoUserName];
        self.wechatOpenid = [aDecoder decodeObjectForKey:kUserInfoWechatOpenid];
        return self;
        
    }
    
    /**
     * Implementation of NSCopying copyWithZone: method
     */
- (instancetype)copyWithZone:(NSZone *)zone
    {
        UserInfoModel *copy = [UserInfoModel new];
        
        copy.gender = self.gender;
        copy.idField = self.idField;
        copy.photo = [self.photo copy];
        copy.registerType = [self.registerType copy];
        copy.shareCode = [self.shareCode copy];
        copy.shareNum = [self.shareNum copy];
        copy.shareStatus = [self.shareStatus copy];
        copy.telephone = [self.telephone copy];
        copy.userName = [self.userName copy];
        copy.wechatOpenid = [self.wechatOpenid copy];
        
        return copy;
    }
    
+ (BOOL)isLoggedIn
    {
        NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
        if ([UserInfoModel findAll].count > 0 && [UserInfoModel findFirstByCriteria:[NSString stringWithFormat:@" where telephone = '%@'",object]] != nil){
            return YES;
        }else{
            return NO;
        }
    }
    
+ (BOOL)logout
    {
        [UserInfoModel shareInstance].gender = 0;
        [UserInfoModel shareInstance].idField = 0;
        [UserInfoModel shareInstance].photo = nil;
        [UserInfoModel shareInstance].registerType = nil;
        [UserInfoModel shareInstance].shareCode = nil;
        [UserInfoModel shareInstance].shareNum = nil;
        [UserInfoModel shareInstance].shareStatus = nil;
        [UserInfoModel shareInstance].telephone = nil;
        [UserInfoModel shareInstance].userName = nil;
        return [UserInfoModel deleteObjectsByCriteria:[NSString stringWithFormat:@" where telephone = '%@'", [UserInfoModel shareInstance].telephone]];
    }

@end
