//
//  RequestGenerator.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "RequestGenerator.h"
#import "NSDictionary+UrlEncoding.h"
#import "Global.h"

@interface RequestGenerator ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *categorySearchTask;

@end

@implementation RequestGenerator


- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return self;
}


- (void)generatePOSTrequest:(NSString *)urlString params:(NSDictionary *)params completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler {

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self formattedCookie] forHTTPHeaderField:@"Cookie"];
    request.HTTPBody = [[params urlEncodedString] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSInteger statusCode = [httpResponse statusCode];
        
        BOOL success = (statusCode == 201 || statusCode == 200) && (error == nil);
        handler(success, statusCode, data);

        
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//        NSInteger statusCode = [httpResponse statusCode];
//        
//        NSLog(@"statusCode %ld", (long)statusCode);
//        
//        if (data) {
//            NSError *error;
//            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSLog(@"info %@", info);
//        }
    }];
    
    [postDataTask resume];
}



- (void)generateGETrequest:(NSString *)urlString completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self formattedCookie] forHTTPHeaderField:@"Cookie"];

    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *postDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSInteger statusCode = [httpResponse statusCode];
        
        BOOL success = (statusCode == 201 || statusCode == 200) && (error == nil);
        handler(success, statusCode, data);
    }];
    
    [postDataTask resume];
}


- (void)searchCategory:(NSString *)urlString completionHandler:(void(^)(BOOL success, NSInteger code, NSData *result))handler {
    if (self.categorySearchTask) {
        [self.categorySearchTask cancel];
    }
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self formattedCookie] forHTTPHeaderField:@"Cookie"];
    
    request.HTTPMethod = @"GET";
    
    self.categorySearchTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSInteger statusCode = [httpResponse statusCode];
        
        BOOL success = (statusCode == 201 || statusCode == 200) && (error == nil);
        handler(success, statusCode, data);
    }];
    
    [self.categorySearchTask  resume];
}

- (NSString *)formattedCookie {
    NSString *sessionId = [[Global sharedInstance] sessionId];
    NSString *sessionField = [NSString stringWithFormat:@"session=%@", sessionId];
    
    return sessionField;
}


@end
