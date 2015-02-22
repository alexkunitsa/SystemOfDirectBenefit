//
//  User+Converter.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "User+Converter.h"

@implementation User (Converter)

- (NSDictionary *)dictionaryWithUser {
    int birthdayTimeStamp = [self.birthday timeIntervalSince1970];
    int nowTimeStamp = [[NSDate date] timeIntervalSince1970];

    NSString *birthdayTimeStampString = [NSString stringWithFormat:@"%d", birthdayTimeStamp];
    NSString *nowTimeStampString = [NSString stringWithFormat:@"%d", nowTimeStamp];

    NSDictionary *userDict = @{
                               @"login":self.login ? self.login : @"",
                               @"pass":self.password ? self.password : @"",
                               @"name":self.name ? self.name : @"",
                               @"email":self.email ? self.email : @"",
                               @"birthday":birthdayTimeStampString ? birthdayTimeStampString : @"",
                               @"gender": @(self.gender),
                               @"registerDate":nowTimeStampString ? nowTimeStampString : @"",
                               @"city":self.city ? self.city : @"",
                               @"tel":self.phone ? self.phone : @"",
                               @"type":@(0),
                               };
    return userDict;
}


- (void)updateWithResponce:(NSDictionary *)dict {
    self.city = dict[@"city"];
    self.login = dict[@"login"];
    self.name = dict[@"name"];
    self.phone = dict[@"tel"];
    self.userId = dict[@"id"];
}

@end