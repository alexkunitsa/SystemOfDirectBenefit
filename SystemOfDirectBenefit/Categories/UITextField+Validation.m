//
//  UITextField+Validation.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "UITextField+Validation.h"

@implementation UITextField (Validation)

- (BOOL)isEmpty {
    BOOL isEmpty = NO;
    if (self.text.length == 0) {
        isEmpty = YES;
    }
    
    return isEmpty;
}


- (void)makeHightlighted {
    [self changeBorderColor:[UIColor redColor]];
}


- (void)makeNormal {
    [self changeBorderColor:[UIColor clearColor]];
}


- (void)changeBorderColor:(UIColor *)color {
    self.layer.cornerRadius=3.0f;
    self.layer.masksToBounds=YES;
    self.layer.borderColor=[color CGColor];
    self.layer.borderWidth= 1.0f;
}

@end
