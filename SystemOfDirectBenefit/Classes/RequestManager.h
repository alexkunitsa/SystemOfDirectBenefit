//
//  RequestManager.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

- (void)registerUser:(User *)user completionHandler:(void(^)(BOOL success))handler;
- (void)login:(NSString *)login password:(NSString *)password completionHandler:(void(^)(BOOL success))handler;

@end
