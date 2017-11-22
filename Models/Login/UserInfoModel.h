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
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * photo;
@property (nonatomic, strong) NSObject * registerType;
@property (nonatomic, strong) NSObject * shareCode;
@property (nonatomic, strong) NSObject * shareNum;
@property (nonatomic, strong) NSObject * shareStatus;
@property (nonatomic, copy) NSString * telephone;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, strong) NSObject * wechatOpenid;
@property (nonatomic, copy) NSString * neteaseAccountId;
@property (nonatomic, copy) NSString * neteaseToken;
    
+ (instancetype)shareInstance;
        
+ (BOOL)logout;
    
+ (BOOL)isLoggedIn;

@end
