//
//  RequestManager.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Item;

@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

- (void)registerUser:(User *)user completionHandler:(void(^)(BOOL success))handler;
- (void)login:(NSString *)login password:(NSString *)password completionHandler:(void(^)(BOOL success))handler;
- (void)receiveUser:(void(^)(BOOL success))handler;
- (void)searchCategory:(NSString *)text completionHandler:(void(^)(BOOL success))handler;
- (void)addItem:(Item *)item completionHandler:(void(^)(BOOL success))handler;
- (void)receiveUserItems:(void(^)(BOOL success))handler;

- (void)searchItem:(NSString *)text completionHandler:(void(^)(BOOL success))handler;

@end
