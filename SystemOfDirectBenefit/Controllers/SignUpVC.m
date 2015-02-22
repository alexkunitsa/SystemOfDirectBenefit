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
#import "UITextField+Validation.h"

@interface SignUpVC ()

@property (nonatomic, strong) UIDatePicker *datePicker;

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
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.birthDateTextField setInputView:self.datePicker];
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
    user.birthday = self.datePicker.date;
    
    if (![self areFieldsValid]) {
        return;
    }

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
        [self performSegueWithIdentifier:@"signUpToProfileSegue" sender:self];
    });
}


#pragma mark - 

-(void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.birthDateTextField.inputView;
    self.birthDateTextField.text = [NSString stringWithFormat:@"%@",picker.date];
}


#pragma mark - Private

- (BOOL)areFieldsValid {
    
    BOOL valid = YES;
    NSArray *fields = @[self.nameTextField, self.loginTextField,  self.passwordTextField, self.confirmPasswordTextField,  self.phoneTextField, self.emailTextField, self.birthDateTextField, self.cityTextField];
    
    for (UITextField *field in fields) {
        
        if ([field isEmpty]) {
            valid = NO;
            [field makeHightlighted];
        }
        else {
            [field makeNormal];
        }
    }
    
    if (![self isValidEmail:self.emailTextField.text]) {
        [self.emailTextField makeHightlighted];
        return NO;
    }
    else {
        [self.emailTextField makeNormal];
    }
    
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [self.passwordTextField makeHightlighted];
        [self.confirmPasswordTextField makeHightlighted];
        
        return NO;
    }
    else {
        [self.passwordTextField makeNormal];
        [self.confirmPasswordTextField makeNormal];
    }
    
    return valid;
}


- (BOOL)isValidEmail:(NSString *)text {
    if (text.length == 0) {
        return NO;
    }
    
    NSString *expression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,100}";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    
    return match != nil;
}


@end
