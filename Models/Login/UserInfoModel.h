//
//  UserInfoModel.h
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"
#import <MJExtension/MJExtension.h>
#import <NIMSDK/NIMSDK.h>

@interface UserInfoModel : JKDBModel
    
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString * idField;
@property (nonatomic, copy) NSString * neteaseAccountId;
@property (nonatomic, copy) NSString * neteaseToken;
@property (nonatomic, copy) NSString * photo;
@property (nonatomic, assign) NSInteger registerType;
@property (nonatomic, copy) NSString * shareCode;
@property (nonatomic, copy) NSString * shareNum;
@property (nonatomic, assign) NSInteger shareStatus;
@property (nonatomic, copy) NSString * telephone;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * wechatOpenid;
@property (nonatomic, copy) NSString * coinAmount;
@property (nonatomic, copy) NSString * provinceName;
@property (nonatomic, copy) NSString * cityName;
@property (nonatomic, copy) NSString * birth;

+ (instancetype)shareInstance;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
        
+ (BOOL)logout;
    
+ (BOOL)isLoggedIn;

@end
