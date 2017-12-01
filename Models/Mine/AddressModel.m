//
//  AddressModel.m
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

#import "AddressModel.h"

NSString *const kAddressModelAddress = @"address";
NSString *const kAddressModelCity = @"city";
NSString *const kAddressModelComment = @"comment";
NSString *const kAddressModelConsignee = @"consignee";
NSString *const kAddressModelCounty = @"county";
NSString *const kAddressModelCreateBy = @"createBy";
NSString *const kAddressModelCreateTime = @"createTime";
NSString *const kAddressModelDefaultFlag = @"defaultFlag";
NSString *const kAddressModelIdField = @"id";
NSString *const kAddressModelProvince = @"province";
NSString *const kAddressModelTelephone = @"telephone";
NSString *const kAddressModelUpdateBy = @"updateBy";
NSString *const kAddressModelUpdateTime = @"updateTime";
NSString *const kAddressModelUserId = @"userId";
NSString *const kAddressModelValidFlag = @"validFlag";
NSString *const kAddressModelVersion = @"version";

@interface AddressModel ()
@end
@implementation AddressModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAddressModelAddress] isKindOfClass:[NSNull class]]){
        self.address = dictionary[kAddressModelAddress];
    }
    if(![dictionary[kAddressModelCity] isKindOfClass:[NSNull class]]){
        self.city = [dictionary[kAddressModelCity] integerValue];
    }
    
    if(![dictionary[kAddressModelComment] isKindOfClass:[NSNull class]]){
        self.comment = dictionary[kAddressModelComment];
    }
    if(![dictionary[kAddressModelConsignee] isKindOfClass:[NSNull class]]){
        self.consignee = dictionary[kAddressModelConsignee];
    }
    if(![dictionary[kAddressModelCounty] isKindOfClass:[NSNull class]]){
        self.county = [dictionary[kAddressModelCounty] integerValue];
    }
    
    if(![dictionary[kAddressModelCreateBy] isKindOfClass:[NSNull class]]){
        self.createBy = dictionary[kAddressModelCreateBy];
    }
    if(![dictionary[kAddressModelCreateTime] isKindOfClass:[NSNull class]]){
        self.createTime = [dictionary[kAddressModelCreateTime] integerValue];
    }
    
    if(![dictionary[kAddressModelDefaultFlag] isKindOfClass:[NSNull class]]){
        self.defaultFlag = dictionary[kAddressModelDefaultFlag];
    }
    if(![dictionary[kAddressModelIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kAddressModelIdField] integerValue];
    }
    
    if(![dictionary[kAddressModelProvince] isKindOfClass:[NSNull class]]){
        self.province = [dictionary[kAddressModelProvince] integerValue];
    }
    
    if(![dictionary[kAddressModelTelephone] isKindOfClass:[NSNull class]]){
        self.telephone = dictionary[kAddressModelTelephone];
    }
    if(![dictionary[kAddressModelUpdateBy] isKindOfClass:[NSNull class]]){
        self.updateBy = dictionary[kAddressModelUpdateBy];
    }
    if(![dictionary[kAddressModelUpdateTime] isKindOfClass:[NSNull class]]){
        self.updateTime = [dictionary[kAddressModelUpdateTime] integerValue];
    }
    
    if(![dictionary[kAddressModelUserId] isKindOfClass:[NSNull class]]){
        self.userId = [dictionary[kAddressModelUserId] integerValue];
    }
    
    if(![dictionary[kAddressModelValidFlag] isKindOfClass:[NSNull class]]){
        self.validFlag = [dictionary[kAddressModelValidFlag] integerValue];
    }
    
    if(![dictionary[kAddressModelVersion] isKindOfClass:[NSNull class]]){
        self.version = dictionary[kAddressModelVersion];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.address != nil){
        dictionary[kAddressModelAddress] = self.address;
    }
    dictionary[kAddressModelCity] = @(self.city);
    if(self.comment != nil){
        dictionary[kAddressModelComment] = self.comment;
    }
    if(self.consignee != nil){
        dictionary[kAddressModelConsignee] = self.consignee;
    }
    dictionary[kAddressModelCounty] = @(self.county);
    if(self.createBy != nil){
        dictionary[kAddressModelCreateBy] = self.createBy;
    }
    dictionary[kAddressModelCreateTime] = @(self.createTime);
    if(self.defaultFlag != nil){
        dictionary[kAddressModelDefaultFlag] = self.defaultFlag;
    }
    dictionary[kAddressModelIdField] = @(self.idField);
    dictionary[kAddressModelProvince] = @(self.province);
    if(self.telephone != nil){
        dictionary[kAddressModelTelephone] = self.telephone;
    }
    if(self.updateBy != nil){
        dictionary[kAddressModelUpdateBy] = self.updateBy;
    }
    dictionary[kAddressModelUpdateTime] = @(self.updateTime);
    dictionary[kAddressModelUserId] = @(self.userId);
    dictionary[kAddressModelValidFlag] = @(self.validFlag);
    if(self.version != nil){
        dictionary[kAddressModelVersion] = self.version;
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
    if(self.address != nil){
        [aCoder encodeObject:self.address forKey:kAddressModelAddress];
    }
    [aCoder encodeObject:@(self.city) forKey:kAddressModelCity];    if(self.comment != nil){
        [aCoder encodeObject:self.comment forKey:kAddressModelComment];
    }
    if(self.consignee != nil){
        [aCoder encodeObject:self.consignee forKey:kAddressModelConsignee];
    }
    [aCoder encodeObject:@(self.county) forKey:kAddressModelCounty];    if(self.createBy != nil){
        [aCoder encodeObject:self.createBy forKey:kAddressModelCreateBy];
    }
    [aCoder encodeObject:@(self.createTime) forKey:kAddressModelCreateTime];    if(self.defaultFlag != nil){
        [aCoder encodeObject:self.defaultFlag forKey:kAddressModelDefaultFlag];
    }
    [aCoder encodeObject:@(self.idField) forKey:kAddressModelIdField];    [aCoder encodeObject:@(self.province) forKey:kAddressModelProvince];    if(self.telephone != nil){
        [aCoder encodeObject:self.telephone forKey:kAddressModelTelephone];
    }
    if(self.updateBy != nil){
        [aCoder encodeObject:self.updateBy forKey:kAddressModelUpdateBy];
    }
    [aCoder encodeObject:@(self.updateTime) forKey:kAddressModelUpdateTime];    [aCoder encodeObject:@(self.userId) forKey:kAddressModelUserId];    [aCoder encodeObject:@(self.validFlag) forKey:kAddressModelValidFlag];    if(self.version != nil){
        [aCoder encodeObject:self.version forKey:kAddressModelVersion];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.address = [aDecoder decodeObjectForKey:kAddressModelAddress];
    self.city = [[aDecoder decodeObjectForKey:kAddressModelCity] integerValue];
    self.comment = [aDecoder decodeObjectForKey:kAddressModelComment];
    self.consignee = [aDecoder decodeObjectForKey:kAddressModelConsignee];
    self.county = [[aDecoder decodeObjectForKey:kAddressModelCounty] integerValue];
    self.createBy = [aDecoder decodeObjectForKey:kAddressModelCreateBy];
    self.createTime = [[aDecoder decodeObjectForKey:kAddressModelCreateTime] integerValue];
    self.defaultFlag = [aDecoder decodeObjectForKey:kAddressModelDefaultFlag];
    self.idField = [[aDecoder decodeObjectForKey:kAddressModelIdField] integerValue];
    self.province = [[aDecoder decodeObjectForKey:kAddressModelProvince] integerValue];
    self.telephone = [aDecoder decodeObjectForKey:kAddressModelTelephone];
    self.updateBy = [aDecoder decodeObjectForKey:kAddressModelUpdateBy];
    self.updateTime = [[aDecoder decodeObjectForKey:kAddressModelUpdateTime] integerValue];
    self.userId = [[aDecoder decodeObjectForKey:kAddressModelUserId] integerValue];
    self.validFlag = [[aDecoder decodeObjectForKey:kAddressModelValidFlag] integerValue];
    self.version = [aDecoder decodeObjectForKey:kAddressModelVersion];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    AddressModel *copy = [AddressModel new];
    
    copy.address = [self.address copy];
    copy.city = self.city;
    copy.comment = [self.comment copy];
    copy.consignee = [self.consignee copy];
    copy.county = self.county;
    copy.createBy = [self.createBy copy];
    copy.createTime = self.createTime;
    copy.defaultFlag = [self.defaultFlag copy];
    copy.idField = self.idField;
    copy.province = self.province;
    copy.telephone = [self.telephone copy];
    copy.updateBy = [self.updateBy copy];
    copy.updateTime = self.updateTime;
    copy.userId = self.userId;
    copy.validFlag = self.validFlag;
    copy.version = [self.version copy];
    
    return copy;
}
@end
