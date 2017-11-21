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
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * isNormal;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * userName;
    
@end
