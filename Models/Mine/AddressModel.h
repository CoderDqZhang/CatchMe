//
//  AddressModel.h
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

#import "JKDBModel.h"

@interface AddressModel : JKDBModel

@property (nonatomic, copy) NSString * address;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, copy) NSObject * comment;
@property (nonatomic, copy) NSString * consignee;
@property (nonatomic, assign) NSInteger county;
@property (nonatomic, strong) NSObject * createBy;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, strong) NSObject * defaultFlag;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, copy) NSString * telephone;
@property (nonatomic, strong) NSObject * updateBy;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger validFlag;
@property (nonatomic, strong) NSObject * version;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
