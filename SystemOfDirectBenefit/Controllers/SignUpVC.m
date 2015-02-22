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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.nameTextField.delegate = self;
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.birthDateTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        if (success) {
            [self pushToProfile];
        }
    }];
}


#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat offset = 188.0f;
    if ([textField isEqual:self.nameTextField] || [textField isEqual:self.loginTextField] || [textField isEqual:self.passwordTextField]) {
        return;
    }
    
    
    [self.scrollView setContentOffset:CGPointMake(0, textField.center.y - offset) animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    return NO;
}


#pragma mark - Navigation

- (void)pushToProfile {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
    });
}


@end
