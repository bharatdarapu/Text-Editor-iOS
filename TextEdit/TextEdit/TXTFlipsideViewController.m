//
//  TXTFlipsideViewController.m
//  TextEdit
//
//  Created by Robert Irwin on 9/23/14.
//  Copyright (c) 2014 Robert Irwin. All rights reserved.
//

#import "TXTFlipsideViewController.h"

// file-level variables to save RGB values
static float red = 0.0;
static float green = 0.0;
static float blue = 0.0;

@interface TXTFlipsideViewController ()
@end

@implementation TXTFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog( @"viewDidLoad, red: %g, green: %g, blue: %g", self.redIntensity.value,
          self.greenIntensity.value, self.blueIntensity.value);
    self.redIntensity.value = red;
    self.greenIntensity.value = green;
    self.blueIntensity.value = blue;
    [self previewColor: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    red = self.redIntensity.value;
    green = self.greenIntensity.value;
    blue = self.blueIntensity.value;
    NSLog( @"done, red: %g, green: %g, blue: %g",
          self.redIntensity.value, self.greenIntensity.value, self.blueIntensity.value);
	[self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)previewColor:(id)sender
{
	self.preview.textColor = [UIColor colorWithRed: self.redIntensity.value
                                        green: self.greenIntensity.value
                                         blue: self.blueIntensity.value
                                        alpha: 1];
    NSLog( @"previewColor, red: %g, green: %g, blue: %g",
          self.redIntensity.value, self.greenIntensity.value, self.blueIntensity.value);
}

@end
