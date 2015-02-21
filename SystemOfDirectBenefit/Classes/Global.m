//
//  Global.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "Global.h"

@implementation Global

#pragma mark - Lifecycle

+ (instancetype)sharedInstance {
    static Global *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init {
    if (self = [super init]) {
        self.currentUser = [[User alloc] init];
    }
    
    return self;
}


- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}


- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
