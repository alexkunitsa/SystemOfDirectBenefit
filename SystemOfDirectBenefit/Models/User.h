//
//  User.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSData *registerDate;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) UserType type;

@end
