//
//  SignUpVC.m
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import "SignUpVC.h"
#import "User.h"
#import "RequestManager.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)createUserAction {
    User *user = [[User alloc] init];
    user.name = self.nameTextField.text;
    user.login = self.loginTextField.text;
    user.password = self.passwordTextField.text;
    user.phone = self.phoneTextField.text;
    user.email = self.emailTextField.text;
    user.city= self.cityTextField.text;
    user.gender = self.genderSegment.selectedSegmentIndex;
    user.phone = self.phoneTextField.text;
    
    [[RequestManager sharedInstance] registerUser:user completionHandler:^(BOOL success) {
        
    }];
    
}

@end
