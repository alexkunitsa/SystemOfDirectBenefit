//
//  ItemCategory+Converter.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "ItemCategory+Converter.h"

@implementation ItemCategory (Converter)

+ (ItemCategory *)itemWithDictionary:(NSDictionary *)dict {
    ItemCategory *category = [[ItemCategory alloc] init];
    category.itemCategoryId = dict[@"id"];
    category.categoryDescription = dict[@"Description"];

    return category;
}

@end
