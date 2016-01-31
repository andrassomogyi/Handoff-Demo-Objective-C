//
//  ViewController.m
//  Handoff Demo Objective C
//
//  Created by Somogyi András on 27/01/16.
//  Copyright © 2016 Andras Somogyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSUserActivity *userActivity;
@property (strong, nonatomic) NSString *messageText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
    
    self.userActivity = [[NSUserActivity alloc] initWithActivityType:@"sa.Handoff-Demo.text"];
    self.userActivity.title = @"Message";
    self.userActivity.userInfo = @{@"text":@""};
    [self.userActivity becomeCurrent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Activity methods

-(void)updateUserActivityState:(NSUserActivity *)activity {
    [activity addUserInfoEntriesFromDictionary:@{@"text": self.messageText}];
    [super updateUserActivityState:activity];
}

-(void)restoreUserActivityState:(NSUserActivity *)activity {
    self.textField.text = activity.userInfo[@"text"];
}

#pragma mark - UITextFieldDelegte methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.messageText = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateUserActivityState:self.userActivity];
    return YES;
}

@end
