//
//  Deal.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deal : NSObject

@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *userId;

@end
