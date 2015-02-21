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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction {
    NSArray *fields = @[self.loginTextField, self.passwordTextField];
    BOOL valid = YES;
    
    for (UITextField *field in fields) {
        if ([field isEmpty]) {
            valid = NO;
            field.textColor = [UIColor redColor];
        }
        else {
            field.textColor = [UIColor grayColor];
        }
    }
    
    if (!valid) {
        return;
    }
    
    NSString *login = self.loginTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [[RequestManager sharedInstance] login:login password:password completionHandler:^(BOOL success) {
        if (success) {
            [self pushToProfile];
        }
    }];
}


#pragma mark - Navigation

- (void)pushToProfile {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
    });
}

@end
