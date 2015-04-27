//
//  TXTMainViewController.m
//  TextEdit
//
//  Created by Robert Irwin on 9/23/14.
//  Edited by Bharath Darapu on 10/10/14
//  Copyright (c) 2014 Robert Irwin. All rights reserved.
//

#import "TXTMainViewController.h"

@interface TXTMainViewController ()

@end


@implementation TXTMainViewController

static NSString *openFileName;

- (void)viewDidLoad
{
    [super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View
- (void)flipsideViewControllerDidFinish:(TXTFlipsideViewController *)controller
{
    self.text.textColor = [UIColor colorWithRed: controller.redIntensity.value
                                         green: controller.greenIntensity.value
                                          blue: controller.blueIntensity.value
                                         alpha: 1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        NSLog(@"in prepareForSegue");
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.text resignFirstResponder];
}


//selecting the items from the tarbar, notice that i didnot declare tabbar controller
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //Opening a new file
    
    //identifying the tab action based on the tag value set
    if(item.tag == 0)
    {
        //open a file
        //popup an alert which contains a textfield to enter the file name
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open File"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"Enter the file name";
        alert.tag = 0;
        [alert show];
  
        }else if(item.tag == 1)
        {
        // insert into a file
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open File"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"Enter the file name";
        alert.tag = 1;
        [alert show];
        
    }else if(item.tag==2)
    {
        //save a file
        
        //if a fileis not already open then it will prompt for a filename
        if(!openFileName)
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"File Name: "
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"Enter the file name";
        alert.tag = 2;
        [alert show];
        }
        else
        {
         //if a file is already open then itwill save the changes to that file
            NSArray *paths = NSSearchPathForDirectoriesInDomains
            (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *file = [NSString stringWithFormat:@"%@/%@.txt",
                              documentsDirectory,openFileName];
            
            NSString *content = _text.text;
            //save content to the documents directory
            [content writeToFile:file
                      atomically:NO
                        encoding:NSStringEncodingConversionAllowLossy
                           error:nil];
            
        }
        
        
    }
    else if(item.tag == 3)
    {
    /*save as a file*/
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save As File"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.placeholder = @"Enter the file name";
        alert.tag = 3;
        [alert show];
    }
    
}



//uialertview delegate method is used to identify which alert was disposed and collect the name of the file for that action
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (alertView.tag)
    {
        case 0:
        {
            openFileName =[[alertView textFieldAtIndex:0] text];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            
            NSString *file = [NSString stringWithFormat:@"%@/%@.txt",
                              path,openFileName];
            
            //check if a file with the file name exits if yes then insert the contents of textview into the file
            if ([[NSFileManager defaultManager] fileExistsAtPath:file])
            {
                NSString *content = [[NSString alloc] initWithContentsOfFile:file
                                                                usedEncoding:nil
                                                                       error:nil];
                _text.text = content;
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"File does not exist"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
        }
            
        case 1:
        {
            NSString *insertFileName;
            insertFileName =[[alertView textFieldAtIndex:0] text];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            
            //if no file is open and insert is clicked then it will prompt for a filename and assign it as initial file
            if(!openFileName)
                openFileName = insertFileName;
            
            NSString *insertFile = [NSString stringWithFormat:@"%@/%@.txt",
                              path,insertFileName];
            
            //check if the file exists, if not then tell the user that the file does not exist
            if ([[NSFileManager defaultManager] fileExistsAtPath:insertFile])
            {
          
                NSString *finalFileContent = [[NSString alloc] initWithContentsOfFile:insertFile
                                                                usedEncoding:nil
                                                                       error:nil];
                
                //get the cursor position and get the string upto the position, insert the new file data here and replace the cursor in its position
                NSRange selectedRange = _text.selectedRange;
                NSString *splitStringPart1 = [_text.text substringToIndex:selectedRange.location];
                NSString *splitStringPart2 = [_text.text substringFromIndex:selectedRange.location];
                
                //concatenating all the strings together and setting the cursor location
                _text.text = [NSString stringWithFormat: @"%@%@%@",
                                   splitStringPart1,
                                   finalFileContent,
                                   splitStringPart2];
                selectedRange.location += [finalFileContent length];
                _text.selectedRange = selectedRange;
            
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"File does not exist"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            break;
            
        }
        case 2:
        {
            openFileName =[[alertView textFieldAtIndex:0] text];
            NSArray *paths = NSSearchPathForDirectoriesInDomains
            (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            
            //make a file name to write the data to using the documents directory:
            NSString *file = [NSString stringWithFormat:@"%@/%@.txt",
                              documentsDirectory,openFileName];
            
            NSString *content = _text.text;
            //save content to file in the documents directory
            
            
            //show the user the status of the save
            bool fileSave = [content writeToFile:file
                      atomically:NO
                        encoding:NSStringEncodingConversionAllowLossy
                           error:nil];
            if(fileSave)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Saved Successfully"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"There was some error"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            break;
        }
        case 3:
        {
            //getting the name of the file to be saved to
            NSString *saveAsFileName = [[alertView textFieldAtIndex:0] text];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains
            (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            
            //make a file name to write the data to using the documents directory:
            NSString *file = [NSString stringWithFormat:@"%@/%@.txt",
                              documentsDirectory,saveAsFileName];

            NSString *content = _text.text;
            //save content to the file in the documents directory
            bool fileSave = [content writeToFile:file
                      atomically:NO
                        encoding:NSStringEncodingConversionAllowLossy
                           error:nil];
            
            openFileName = saveAsFileName;
            
            
            //show the status of the file save to the user
            if(fileSave)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Saved Successfully"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"There was some error"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
            break;
        }
    }
}

@end
