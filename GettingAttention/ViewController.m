//
//  ViewController.m
//  GettingAttention
//
//  Created by Luck Lui on 26/8/14.
//  Copyright (c) 2014 Rabeanco. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userOutput;

- (IBAction)doAlerts:(id)sender;
- (IBAction)doAlertInput:(id)sender;
- (IBAction)doActionSheet:(id)sender;
- (IBAction)doSound:(id)sender;
- (IBAction)doVibration:(id)sender;

@end

@implementation ViewController

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

- (IBAction)doAlerts:(id)sender {
    UIAlertView *alertDialog;
    alertDialog = [[UIAlertView alloc]
                   initWithTitle:nil
                   message:@"I need your attention NOW!"
                   delegate:self
                   cancelButtonTitle:@"OK"
                   otherButtonTitles: @"Maybe Later",@"Never",nil
                   
                   
                   ];
    [alertDialog show];
}

- (IBAction)doAlertInput:(id)sender {
    UIAlertView *alertDialog;
    alertDialog = [[UIAlertView alloc]
                   initWithTitle:@"Email Address"
                   message:@"Please enter your email address"
                   delegate:self
                   cancelButtonTitle:@"OK"
                   otherButtonTitles: nil];
    
    alertDialog.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alertDialog show];
}

- (IBAction)doActionSheet:(id)sender {
    UIActionSheet *actionSheet;
    actionSheet = [
                  [UIActionSheet alloc]
                   initWithTitle:@"Available Actions"
                   delegate:self
                   cancelButtonTitle:@"Cancel"
                   destructiveButtonTitle:@"Destory"
                   otherButtonTitles:@"Negotiate",@"Compromise", nil
                  ];
    actionSheet.actionSheetStyle=UIActionSheetStyleDefault;
    [actionSheet showFromRect:[(UIButton *)sender frame]
                       inView:self.view
                        animated:YES];
}

- (IBAction)doSound:(id)sender {
    SystemSoundID soundID;
    NSString *soundFile = [
                          [NSBundle mainBundle]
                          pathForResource:@"soundeffect" ofType:@"wav"
                          ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (IBAction)doVibration:(id)sender {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Maybe Later"]) {
        self.userOutput.text = @"Clicked 'Maybe Later'";
    }else if ([buttonTitle isEqualToString:@"Never"]){
        self.userOutput.text=@"Clicked 'Never'";
    }else{
        self.userOutput.text=@"Clicked 'OK'";
    }
    
    if ([alertView.title isEqualToString:@"Email Address"]) {
        self.userOutput.text=[[alertView textFieldAtIndex:0] text];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Destory"]) {
        self.userOutput.text = @"Clicked 'Destory'";
    }else if ([buttonTitle isEqualToString:@"Negotiate"]){
        self.userOutput.text=@"Clicked 'Negotiate'";
    }else if([buttonTitle isEqualToString:@"Compromise"]){
        self.userOutput.text=@"Clicked 'Compromise'";
    }else{
        self.userOutput.text=@"Clicked 'Cancel'";
    }
}





@end
