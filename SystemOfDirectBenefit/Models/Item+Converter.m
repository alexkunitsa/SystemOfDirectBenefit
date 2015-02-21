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
                           @"categoryid":self.categoryId ? self.categoryId : @"",
                           @"description":self.itemDescription ? self.itemDescription : @""};
    
    return dict;
}


@end
