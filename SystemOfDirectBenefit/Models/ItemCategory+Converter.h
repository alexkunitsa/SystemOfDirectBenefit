//
//  ItemCategory+Converter.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/22/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "ItemCategory.h"

@interface ItemCategory (Converter)

+ (ItemCategory *)itemWithDictionary:(NSDictionary *)dict;

@end
