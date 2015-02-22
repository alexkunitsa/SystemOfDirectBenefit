//
//  SignInVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "SignInVC.h"
#import "RequestManager.h"
#import "UITextField+Validation.h"
#import <QuartzCore/QuartzCore.h>

@interface SignInVC ()

@end


@implementation SignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *lastLogin = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastLogin"];
    self.loginTextField.text = lastLogin;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

- (IBAction)loginAction {
    BOOL valid = [self areFieldsValid];
    if (!valid) {
        return;
    }
    
    NSString *login = self.loginTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [[RequestManager sharedInstance] login:login password:password completionHandler:^(BOOL success) {
        if (success) {
            NSString *valueToSave = login;
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"lastLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self pushToProfile];
        }
        else {
            [self loginFailed];
        }
    }];
}


#pragma mark - Private

- (BOOL)areFieldsValid {
    BOOL valid = YES;
    NSArray *fields = @[self.loginTextField, self.passwordTextField];
    
    for (UITextField *field in fields) {
        
        if ([field isEmpty]) {
            valid = NO;
            [field makeHightlighted];
        }
        else {
            [field makeNormal];
        }
    }
    
    return valid;
}


- (void)loginFailed {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User was not logged in" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
    [self.view endEditing:YES];
}


#pragma mark - Navigation

- (void)pushToProfile {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
    });
}

@end
