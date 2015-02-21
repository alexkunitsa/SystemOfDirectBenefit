//
//  Item.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *pictureId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, assign) NSInteger resourceType;
@property (nonatomic, assign) NSInteger dealAccept;

@end
