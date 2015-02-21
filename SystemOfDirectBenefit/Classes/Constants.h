//
//  Constants.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

typedef NS_ENUM(NSInteger, UserType) {
    UserTypeGiveOnly,
    UserTypeGiveAndReceive,
};

typedef NS_ENUM(NSInteger, Gender) {
    GenderMale,
    GenderFemale,
};

extern NSString *const kServiceURL;


@end
