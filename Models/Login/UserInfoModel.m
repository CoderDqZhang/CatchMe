//
//  UserInfoModel.m
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

#import "UserInfoModel.h"

NSString *const kHomeLabelsGender = @"gender";
NSString *const kHomeLabelsIdField = @"id";
NSString *const kHomeLabelsNeteaseAccountId = @"neteaseAccountId";
NSString *const kHomeLabelsNeteaseToken = @"neteaseToken";
NSString *const kHomeLabelsPhoto = @"photo";
NSString *const kHomeLabelsRegisterType = @"registerType";
NSString *const kHomeLabelsShareCode = @"shareCode";
NSString *const kHomeLabelsShareNum = @"shareNum";
NSString *const kHomeLabelsShareStatus = @"shareStatus";
NSString *const kHomeLabelsTelephone = @"telephone";
NSString *const kHomeLabelsToken = @"token";
NSString *const kHomeLabelsUserName = @"userName";
NSString *const kHomeLabelsWechatOpenid = @"wechatOpenid";
NSString *const kHomeLabelsCoinAmount = @"coinAmount";

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
        NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"neteaseAccountId"];
        if ([UserInfoModel findAll].count > 0 ) {
            _instance =  [UserInfoModel findFirstByCriteria:[NSString stringWithFormat:@" where neteaseAccountId = '%@'",object]];
        }else{
            _instance = [[UserInfoModel alloc] init];
        }
    });
    return _instance;
}

    
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kHomeLabelsGender] isKindOfClass:[NSNull class]]){
        self.gender = [dictionary[kHomeLabelsGender] integerValue];
    }
    
    if(![dictionary[kHomeLabelsIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kHomeLabelsIdField] stringValue];
    }
    if(![dictionary[kHomeLabelsCoinAmount] isKindOfClass:[NSNull class]]){
        self.coinAmount = [dictionary[kHomeLabelsCoinAmount] stringValue];
    }
    
    if(![dictionary[kHomeLabelsNeteaseAccountId] isKindOfClass:[NSNull class]]){
        self.neteaseAccountId = dictionary[kHomeLabelsNeteaseAccountId];
    }
    if(![dictionary[kHomeLabelsToken] isKindOfClass:[NSNull class]]){
        self.neteaseToken = dictionary[kHomeLabelsToken];
    }
    if(![dictionary[kHomeLabelsPhoto] isKindOfClass:[NSNull class]]){
        self.photo = dictionary[kHomeLabelsPhoto];
    }
    if(![dictionary[kHomeLabelsRegisterType] isKindOfClass:[NSNull class]]){
        self.registerType = [dictionary[kHomeLabelsRegisterType] integerValue];
    }
    
    if(![dictionary[kHomeLabelsShareCode] isKindOfClass:[NSNull class]]){
        self.shareCode = dictionary[kHomeLabelsShareCode];
    }
    if(![dictionary[kHomeLabelsShareNum] isKindOfClass:[NSNull class]]){
        self.shareNum = dictionary[kHomeLabelsShareNum];
    }
    if(![dictionary[kHomeLabelsShareStatus] isKindOfClass:[NSNull class]]){
        self.shareStatus = [dictionary[kHomeLabelsShareStatus] integerValue];
    }
    
    if(![dictionary[kHomeLabelsTelephone] isKindOfClass:[NSNull class]]){
        self.telephone = dictionary[kHomeLabelsTelephone];
    }
    if(![dictionary[kHomeLabelsToken] isKindOfClass:[NSNull class]]){
        self.token = dictionary[kHomeLabelsToken];
    }
    if(![dictionary[kHomeLabelsUserName] isKindOfClass:[NSNull class]]){
        self.userName = dictionary[kHomeLabelsUserName];
    }
    if(![dictionary[kHomeLabelsWechatOpenid] isKindOfClass:[NSNull class]]){
        self.wechatOpenid = dictionary[kHomeLabelsWechatOpenid];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kHomeLabelsGender] = @(self.gender);
    dictionary[kHomeLabelsIdField] = self.idField;
    dictionary[kHomeLabelsCoinAmount] = self.coinAmount;
    if(self.neteaseAccountId != nil){
        dictionary[kHomeLabelsNeteaseAccountId] = self.neteaseAccountId;
    }
    if(self.photo != nil){
        dictionary[kHomeLabelsPhoto] = self.photo;
    }
    dictionary[kHomeLabelsRegisterType] = @(self.registerType);
    if(self.shareCode != nil){
        dictionary[kHomeLabelsShareCode] = self.shareCode;
    }
    if(self.shareNum != nil){
        dictionary[kHomeLabelsShareNum] = self.shareNum;
    }
    dictionary[kHomeLabelsShareStatus] = @(self.shareStatus);
    if(self.telephone != nil){
        dictionary[kHomeLabelsTelephone] = self.telephone;
    }
    if(self.token != nil){
        dictionary[kHomeLabelsToken] = self.token;
    }
    if(self.userName != nil){
        dictionary[kHomeLabelsUserName] = self.userName;
    }
    if(self.wechatOpenid != nil){
        dictionary[kHomeLabelsWechatOpenid] = self.wechatOpenid;
    }
    if(self.neteaseToken != nil){
        dictionary[kHomeLabelsToken] = self.neteaseToken;
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
    [aCoder encodeObject:@(self.gender) forKey:kHomeLabelsGender];    [aCoder encodeObject:self.idField forKey:kHomeLabelsIdField];
    if(self.neteaseAccountId != nil){
        [aCoder encodeObject:self.neteaseAccountId forKey:kHomeLabelsNeteaseAccountId];
    }
    if(self.neteaseToken != nil){
        [aCoder encodeObject:self.neteaseToken forKey:kHomeLabelsToken];
    }
    
    if(self.coinAmount != nil){
        [aCoder encodeObject:self.coinAmount forKey:kHomeLabelsCoinAmount];
    }
    
    if(self.photo != nil){
        [aCoder encodeObject:self.photo forKey:kHomeLabelsPhoto];
    }
    [aCoder encodeObject:@(self.registerType) forKey:kHomeLabelsRegisterType];    if(self.shareCode != nil){
        [aCoder encodeObject:self.shareCode forKey:kHomeLabelsShareCode];
    }
    if(self.shareNum != nil){
        [aCoder encodeObject:self.shareNum forKey:kHomeLabelsShareNum];
    }
    [aCoder encodeObject:@(self.shareStatus) forKey:kHomeLabelsShareStatus];    if(self.telephone != nil){
        [aCoder encodeObject:self.telephone forKey:kHomeLabelsTelephone];
    }
    if(self.token != nil){
        [aCoder encodeObject:self.token forKey:kHomeLabelsToken];
    }
    if(self.userName != nil){
        [aCoder encodeObject:self.userName forKey:kHomeLabelsUserName];
    }
    if(self.wechatOpenid != nil){
        [aCoder encodeObject:self.wechatOpenid forKey:kHomeLabelsWechatOpenid];
    }
    
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.gender = [[aDecoder decodeObjectForKey:kHomeLabelsGender] integerValue];
    self.idField = [[aDecoder decodeObjectForKey:kHomeLabelsIdField] stringValue];
    self.neteaseAccountId = [aDecoder decodeObjectForKey:kHomeLabelsNeteaseAccountId];
    self.neteaseToken = [aDecoder decodeObjectForKey:kHomeLabelsToken];
    self.photo = [aDecoder decodeObjectForKey:kHomeLabelsPhoto];
    self.registerType = [[aDecoder decodeObjectForKey:kHomeLabelsRegisterType] integerValue];
    self.shareCode = [aDecoder decodeObjectForKey:kHomeLabelsShareCode];
    self.shareNum = [aDecoder decodeObjectForKey:kHomeLabelsShareNum];
    self.shareStatus = [[aDecoder decodeObjectForKey:kHomeLabelsShareStatus] integerValue];
    self.telephone = [aDecoder decodeObjectForKey:kHomeLabelsTelephone];
    self.token = [aDecoder decodeObjectForKey:kHomeLabelsToken];
    self.coinAmount = [aDecoder decodeObjectForKey:kHomeLabelsCoinAmount];
    self.userName = [aDecoder decodeObjectForKey:kHomeLabelsUserName];
    self.wechatOpenid = [aDecoder decodeObjectForKey:kHomeLabelsWechatOpenid];
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
    copy.neteaseAccountId = [self.neteaseAccountId copy];
    copy.neteaseToken = [self.neteaseToken copy];
    copy.photo = [self.photo copy];
    copy.registerType = self.registerType;
    copy.shareCode = [self.shareCode copy];
    copy.shareNum = [self.shareNum copy];
    copy.shareStatus = self.shareStatus;
    copy.telephone = [self.telephone copy];
    copy.token = [self.token copy];
    copy.userName = [self.userName copy];
    copy.wechatOpenid = [self.wechatOpenid copy];
    copy.coinAmount = [self.coinAmount copy];
    return copy;
}

+ (BOOL)isLoggedIn
    {
        NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"neteaseAccountId"];
        if ([UserInfoModel findAll].count > 0 && [UserInfoModel findFirstByCriteria:[NSString stringWithFormat:@" where neteaseAccountId = '%@'",object]] != nil){
            return YES;
        }else{
            return NO;
        }
    }
    
+ (BOOL)logout
    {
        [UserInfoModel shareInstance].gender = 0;
        [UserInfoModel shareInstance].idField = nil;
        [UserInfoModel shareInstance].photo = nil;
        [UserInfoModel shareInstance].neteaseToken = nil;
        [UserInfoModel shareInstance].registerType = 0;
        [UserInfoModel shareInstance].shareCode = nil;
        [UserInfoModel shareInstance].shareNum = nil;
        [UserInfoModel shareInstance].shareStatus = 0;
        [UserInfoModel shareInstance].telephone = nil;
        [UserInfoModel shareInstance].userName = nil;
        [UserInfoModel shareInstance].neteaseAccountId = nil;
        [UserInfoModel shareInstance].token = nil;
        [UserInfoModel shareInstance].coinAmount = nil;
        NSObject *object = [[NSUserDefaults standardUserDefaults] objectForKey:@"neteaseAccountId"];
        return [UserInfoModel deleteObjectsByCriteria:[NSString stringWithFormat:@" where neteaseAccountId = '%@'", object]];
    }

@end
