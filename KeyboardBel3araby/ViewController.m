//
//  ViewController.m
//  KeyboardBel3araby
//
//  Created by OsamaMac on 11/2/14.
//  Copyright (c) 2014 arabdevs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)buttonsRedClicked:(id)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor redColor]];
    [defaults setObject:colorData forKey:@"lettersColor"];
    [defaults synchronize];
}
- (IBAction)buttonsBlueClicked:(id)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blueColor]];
    [defaults setObject:colorData forKey:@"lettersColor"];
    [defaults synchronize];
}
- (IBAction)backgroundRedClicked:(id)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor redColor]];
    [defaults setObject:colorData forKey:@"bgColor"];
    [defaults synchronize];
}
- (IBAction)backGroundBlueClicked:(id)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blueColor]];
    [defaults setObject:colorData forKey:@"bgColor"];
    [defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
