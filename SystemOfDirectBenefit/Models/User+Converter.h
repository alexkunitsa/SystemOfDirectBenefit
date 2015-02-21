//
//  User+Converter.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "User.h"

@interface User (Converter)

- (NSDictionary *)dictionaryWithUser;
- (void)updateWithResponce:(NSDictionary *)dict;

@end