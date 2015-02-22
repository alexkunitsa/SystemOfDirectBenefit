//
//  Deal+Converter.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "Deal+Converter.h"

@implementation Deal (Converter)

+ (Deal *)dealWithDictionary:(NSDictionary *)dict {
    Deal *deal = [[Deal alloc] init];
    deal.dealId = dict[@"id"];
    deal.status = dict[@"id_status"];
    deal.ownerId = dict[@"id_user_receive"];
    deal.userId = dict[@"id_user_item"];

    return deal;
}

@end
