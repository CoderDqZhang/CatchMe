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

@interface UserInfoModel : JKDBModel
    
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * photo;
@property (nonatomic, strong) NSObject * registerType;
@property (nonatomic, strong) NSObject * shareCode;
@property (nonatomic, strong) NSObject * shareNum;
@property (nonatomic, strong) NSObject * shareStatus;
@property (nonatomic, strong) NSString * telephone;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSObject * wechatOpenid;
    
+ (instancetype)shareInstance;
    
+ (void)toUserInstance:(UserInfoModel *)userInfo;
    
+ (BOOL)logout;
    
+ (BOOL)isLoggedIn;

@end
