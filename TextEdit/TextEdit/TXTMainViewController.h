//
//  TXTMainViewController.h
//  TextEdit
//
//  Created by Robert Irwin on 9/23/14.
//  Edited by Bharath Darapu on 10/10/14
//  Copyright (c) 2014 Robert Irwin. All rights reserved.
//

#import "TXTFlipsideViewController.h"

@interface TXTMainViewController : UIViewController <TXTFlipsideViewControllerDelegate,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITextView *text; //uitextview which will actually contain the text
@property (weak, nonatomic) IBOutlet UITabBar *tabBar; //uitabbar which holds the buttons to perform respective actions

- (IBAction)hideKeyboard:(id)sender;

@end
