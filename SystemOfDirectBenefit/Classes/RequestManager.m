//
//  RequestManager.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "RequestManager.h"
#import "User+Converter.h"
#import "Constants.h"
#import "RequestGenerator.h"

@interface RequestManager()

@property (nonatomic, strong) NSURLSession *session;
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
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
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
        
        if (result) {
            NSError *error;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
            NSLog(@"info %@", info);
        }
        
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
        NSLog(@"info %@", info);
    
        handler(success);
    }];
}

@end
