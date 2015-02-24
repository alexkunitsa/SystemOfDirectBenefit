//
//  Item+Converter.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "Item+Converter.h"

@implementation Item (Converter)

- (NSDictionary *)dictionaryWithItem {
    NSDictionary *dict = @{
                           @"name":self.name ? self.name : @"",
                           @"RequestType":@(self.isRequestItem),
                           @"categoryid":self.categoryId ? self.categoryId : @"",
                           @"method":@(self.dealAccept),
                           @"type":@(self.resourceType),
                           @"description":self.itemDescription ? self.itemDescription : @""};
    
    return dict;
}


+ (Item *)itemWithDictionary:(NSDictionary *)dict {
    Item *item = [[Item alloc] init];
    item.itemId = dict[@"id"];
    item.itemDescription = dict[@"description"];
    item.name = dict[@"name"];
    item.resourceType = [dict[@"type"] integerValue];
    item.dealAccept = [dict[@"method"] integerValue];
    
    NSString *imageLink = dict[@"photo_link"];
    if ([imageLink isKindOfClass:[NSString class]]) {
        item.pictureId = imageLink;
    }

    return item;
}


@end
