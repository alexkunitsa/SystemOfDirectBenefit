//
//  SignUpVC.h
//  SystemOfDirectBenefit
//
//  Created by Alex Kunitsa on 2/21/15.
//  Copyright (c) 2015 Alex Kunitsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpVC : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *loginTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField *birthDateTextField;
@property (nonatomic, weak) IBOutlet UITextField *cityTextField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *genderSegment;

- (IBAction)createUserAction;

@end
