//
//  Keyboard.h
//  KeyboardBel3araby
//
//  Created by OsamaMac on 11/2/14.
//  Copyright (c) 2014 arabdevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Keyboard : UIInputView
@property (weak, nonatomic) IBOutlet UIButton *showNumericButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *hideKeyboardButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ButtonArrays;


@end
