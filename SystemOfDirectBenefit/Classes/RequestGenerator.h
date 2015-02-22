//
//  RequestGenerator.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestGenerator : NSObject

- (void)generatePOSTrequest:(NSString *)urlString params:(NSDictionary *)params completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler;

- (void)generateGETrequest:(NSString *)urlString completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler;


- (void)searchCategory:(NSString *)urlString completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler;



@end
