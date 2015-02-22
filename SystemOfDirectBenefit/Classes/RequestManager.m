//
//  RequestManager.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "RequestManager.h"
#import "User+Converter.h"
#import "Item+Converter.h"
#import "ItemCategory+Converter.h"
#import "Constants.h"
#import "RequestGenerator.h"
#import "Global.h"
#import "User.h"
#import "Deal+Converter.h"

@interface RequestManager()

@property (nonatomic, strong) RequestGenerator *requestGenerator;

@end


@implementation RequestManager

#pragma mark - Lifecycle

+ (instancetype)sharedInstance {
    static RequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init {
    if (self = [super init]) {
        self.requestGenerator = [[RequestGenerator alloc] init];
    }
    
    return self;
}


- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}


- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


#pragma mark - Public

- (void)registerUser:(User *)user completionHandler:(void(^)(BOOL success))handler {
    NSDictionary *params = [user dictionaryWithUser];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServiceURL, @"signup"];
   
    [self.requestGenerator generatePOSTrequest:urlString params:params completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSLog(@"sign up statusCode %ld", (long)code);
        
        NSError *error;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        NSString *session = info[@"session"];
        if (session.length > 0) {
            [[Global sharedInstance] setSessionId:session];
        }
        
        NSLog(@"info %@", info);
        
        handler(success);
    }];
}


- (void)login:(NSString *)login password:(NSString *)password completionHandler:(void(^)(BOOL success))handler {
    NSDictionary *params = @{@"login":login, @"pass":password};
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServiceURL, @"login"];
    
    [self.requestGenerator generatePOSTrequest:urlString params:params completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSLog(@"login statusCode %ld", (long)code);
        
        NSError *error;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        NSString *session = info[@"session"];
        if (session.length > 0) {
            [[Global sharedInstance] setSessionId:session];
        }
        
        NSLog(@"info %@", info);
    
        handler(success);
    }];
}


- (void)receiveUser:(void(^)(BOOL success))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServiceURL, @"user"];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        
        NSLog(@"receive user statusCode %ld", (long)code);
        
        NSError *error;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        
        User *currentUser = [[Global sharedInstance] currentUser];
        [currentUser updateWithResponce:info];
    
        handler(success);
    }];
}


- (void)searchCategory:(NSString *)text completionHandler:(void(^)(BOOL success, NSArray *items))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", kServiceURL, @"category?text=", text];
   
    [self.requestGenerator searchCategory:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSError *error;
        NSArray *items = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        
        NSMutableArray *resultItems = [[NSMutableArray alloc] init];
        for (NSDictionary *info in items) {
            ItemCategory *category = [ItemCategory itemWithDictionary:info];
            [resultItems addObject:category];
        }
        
        handler(success, resultItems);
    }];
}


- (void)addItem:(Item *)item completionHandler:(void(^)(BOOL success))handler {
    NSDictionary *params = [item dictionaryWithItem];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServiceURL, @"item"];
    
    [self.requestGenerator generatePOSTrequest:urlString params:params completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSLog(@"add item up statusCode %ld", (long)code);
        
//        NSError *error;
//        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
//        NSString *session = info[@"session"];
//        if (session.length > 0) {
//            [[Global sharedInstance] setSessionId:session];
//        }
        
//        NSLog(@"info %@", info);
        
        handler(success);
    }];
}


- (void)receiveUserItems:(BOOL)isRequestType completionHandler:(void(^)(BOOL success, NSArray *items))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%i", kServiceURL, @"items?type=", isRequestType];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSLog(@"receive user items statusCode %ld", (long)code);
        
        NSError *error;
        NSArray *items = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        
        NSMutableArray *resultItems = [[NSMutableArray alloc] init];
        for (NSDictionary *info in items) {
            Item *item = [Item itemWithDictionary:info];
            [resultItems addObject:item];
        }
        
        handler(success, resultItems);
    }];
}


- (void)searchItem:(NSString *)text completionHandler:(void(^)(BOOL success, NSArray *items ))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@search?title=%@&category=%@&city=%@", kServiceURL, text, @"", @""];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        NSLog(@"receive user statusCode %ld", (long)code);
        
        NSError *error;
        NSArray *items = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
        NSMutableArray *resultItems = [[NSMutableArray alloc] init];
        for (NSDictionary *info in items) {
            Item *item = [Item itemWithDictionary:info];
            [resultItems addObject:item];
        }
        
        handler(success, resultItems);
    }];
}


- (void)addDeal:(NSString *)itemId completionHandler:(void(^)(BOOL success))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", kServiceURL, @"deal?item=", itemId];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        
        handler(success);
    }];
}


- (void)changeDealStatus:(NSString *)dealId status:(NSNumber *)status completionHandler:(void(^)(BOOL success))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@updatedeal?IDdeal=%@&status=%ld", kServiceURL, dealId, (long)status.integerValue];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        
        handler(success);
    }];

}


- (void)receiveDeals:(void(^)(BOOL success, NSMutableDictionary *items))handler {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kServiceURL, @"deals"];
    
    [self.requestGenerator generateGETrequest:urlString completionHandler:^(BOOL success, NSInteger code, NSData *result) {
        
        NSError *error;
        NSArray *items = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];

        NSMutableDictionary *resultItems = [[NSMutableDictionary alloc] init];
        resultItems[@"0"] = [[NSMutableArray alloc] init];
        resultItems[@"1"] = [[NSMutableArray alloc] init];
        resultItems[@"2"] = [[NSMutableArray alloc] init];
        resultItems[@"3"] = [[NSMutableArray alloc] init];
        resultItems[@"4"] = [[NSMutableArray alloc] init];
        
        for (NSDictionary *info in items) {
            Deal *deal = [Deal dealWithDictionary:info];
            
            if ([deal.status isEqualToString:@"0"]) {
                [resultItems[@"0"] addObject:deal];
            }
            else if ([deal.status isEqualToString:@"1"]) {
                [resultItems[@"1"] addObject:deal];
            }
            else if ([deal.status isEqualToString:@"2"]) {
                [resultItems[@"2"] addObject:deal];
            }
            else if ([deal.status isEqualToString:@"3"]) {
                [resultItems[@"3"] addObject:deal];
            }
            else if ([deal.status isEqualToString:@"4"]) {
                [resultItems[@"4"] addObject:deal];
            }
        }
        
        handler(success, resultItems);
    }];
}

@end
