//
//  Global.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Global : NSObject

@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSString *sessionId;

@end