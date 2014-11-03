//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by OsamaMac on 11/2/14.
//  Copyright (c) 2014 arabdevs. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Keyboard.h"


@interface KeyboardViewController ()
@property (nonatomic, strong) Keyboard* keyboard;

@property (nonatomic, strong) PopoverView *pv;
@property (nonatomic) CGPoint point;
@property( nonatomic, strong)UILongPressGestureRecognizer *grH;
@property( nonatomic, strong)UILongPressGestureRecognizer *grY;
@property( nonatomic, strong)UILongPressGestureRecognizer *grL;
@property( nonatomic, strong)UILongPressGestureRecognizer *grA;
@property( nonatomic, strong)UILongPressGestureRecognizer *grO;
@property( nonatomic, strong)UILongPressGestureRecognizer *grOmlut;

@end


#define kStringArrayH [NSArray arrayWithObjects:@"ه", @"هـ", nil]
#define kStringArrayY [NSArray arrayWithObjects:@"ئ", @"ي", nil]
#define kStringArrayL [NSArray arrayWithObjects:@"لا", @"ل", nil]
#define kStringArrayA [NSArray arrayWithObjects:@"أ", @"ا",@"إ",@"آ",@"ء",@"لا", nil]
#define kStringArrayO [NSArray arrayWithObjects:@"ؤ", @"و", nil]
#define kStringArrayOmlut [NSArray arrayWithObjects:@"ٰ",@" ُ",@" ِ",@"ـ",@" ٓ",@" ْ"@" ٍ",@" ٌ",@" ّ",@" َ",nil]
#define kImageArray [NSArray arrayWithObjects:[UIImage imageNamed:@"success"], [UIImage imageNamed:@"error"], nil]


#define kAlphaKeyboardArray [NSArray arrayWithObjects:@"ض",@"ص",@"ق",@"ف",@"غ",@"ع",@"ه",@"خ",@"ح",@"ج",@"ش",@"س",@"ي",@"ب",@"ل",@"ا",@"ت",@"ن",@"م",@"ك",@"ظ",@"ط",@"ذ",@"د",@"ز",@"ر",@"و",@"ة",@"ث", nil]

#define kCharOneKeyboardArray [NSArray arrayWithObjects:@"-",@"/",@":",@"؛",@"(",@")",@"£",@"&",@"@",@"\"",@".",@"،",@"؟",@"!",@"‘",@"ريال",@"درهم",@"دينار",@"جنيه",@"👞",@"#+=",@"🎽",@"👢",@"👒",@"💭",@"💫",@"💄",@"💌",@"👝",nil]

#define kCharTwoKeyboardArray [NSArray arrayWithObjects:@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"\\",@"|",@"~",@"<",@">",@"ريال",@"$",@"€",@"●",@"٣٢١",@".",@",",@"?",@"!",@"'",@"ω",@"ϑ",@"θ",nil]

@implementation KeyboardViewController
{
    int current;
}

@synthesize  grA,grH,grL,grO,grY,pv,point,grOmlut;

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    
    NSData *colorData = [defaults objectForKey:@"bgColor"];
    
    
    
    
    current = 0;
    
    // Perform custom UI setup here
    self.keyboard = [[[NSBundle mainBundle]loadNibNamed:@"Keyboard" owner:nil options:nil] objectAtIndex:0];
    if(colorData)
    {
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        [self.keyboard.mainView setBackgroundColor:color];
    }
    
    [self addKeyBoardGestures];
    self.inputView = self.keyboard;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}


#pragma mark keyboard gestures
-(void)addKeyBoardGestures
{
    [self.keyboard.deleteButton addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.spaceButton addTarget:self action:@selector(spaceClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.hideKeyboardButton addTarget:self action:@selector(hideClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.showNumericButton addTarget:self action:@selector(showNumericClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.nextButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    
    grH = [[UILongPressGestureRecognizer alloc] init];
    [grH addTarget:self action:@selector(userLongPressedH:)];
    
    grO = [[UILongPressGestureRecognizer alloc] init];
    [grO addTarget:self action:@selector(userLongPressedO:)];
    
    grY = [[UILongPressGestureRecognizer alloc] init];
    [grY addTarget:self action:@selector(userLongPressedY:)];
    
    grL = [[UILongPressGestureRecognizer alloc] init];
    [grL addTarget:self action:@selector(userLongPressedL:)];
    
    
    grA = [[UILongPressGestureRecognizer alloc] init];
    [grA addTarget:self action:@selector(userLongPressedA:)];
    
    grOmlut = [[UILongPressGestureRecognizer alloc] init];
    [grOmlut addTarget:self action:@selector(userLongPressedOmlut:)];
    
    
    for(UIButton* button in self.keyboard.ButtonArrays)
    {
        
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
        
        NSData *colorData = [defaults objectForKey:@"lettersColor"];
        
        if(colorData)
        {
            UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        
            [button setBackgroundColor:color];
        }
        
        [button removeTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchUpInside];
     
        
        if([button.titleLabel.text isEqualToString:@"ا"])
        {
            [button removeGestureRecognizer:grA];
            [button addGestureRecognizer:grA];
        }else if([button.titleLabel.text isEqualToString:@"و"])
        {
            [button removeGestureRecognizer:grO];
            [button addGestureRecognizer:grO];
        }else if([button.titleLabel.text isEqualToString:@"ل"])
        {
            [button removeGestureRecognizer:grL];
            [button addGestureRecognizer:grL];
        }else if([button.titleLabel.text isEqualToString:@"ه"])
        {
            [button removeGestureRecognizer:grH];
            [button addGestureRecognizer:grH];
        }else if([button.titleLabel.text isEqualToString:@"ي"])
        {
            [button removeGestureRecognizer:grY];
            [button addGestureRecognizer:grY];
        }else if([button.titleLabel.text isEqualToString:@"ً"])
        {
            [button removeGestureRecognizer:grOmlut];
            [button addGestureRecognizer:grOmlut];
        }
    }
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.arabdevs.keyboardy"];
    
    NSData *colorData = [defaults objectForKey:@"lettersColor"];

    if(colorData)
    {
        UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        
        [self.keyboard.spaceButton setBackgroundColor:color];
        [self.keyboard.deleteButton setBackgroundColor:color];
        [self.keyboard.showNumericButton setBackgroundColor:color];
        [self.keyboard.nextButton setBackgroundColor:color];
        [self.keyboard.hideKeyboardButton setBackgroundColor:color];
    }
    

}

-(void)deleteClicked:(id)sender
{
    [self.textDocumentProxy deleteBackward];
}

-(void)showNumericClicked:(id)sender
{
    current++;
    if(current%2 == 1)
    {
        for(UIButton* button in self.keyboard.ButtonArrays)
        {
            if(button.tag >=1 && button.tag <= 29)
            {
                [button setTitle:[kCharOneKeyboardArray objectAtIndex:(button.tag-1)] forState:UIControlStateNormal];
            }
        }
    }else
    {
        for(UIButton* button in self.keyboard.ButtonArrays)
        {
            if(button.tag >=1 && button.tag <= 29)
            {
                [button setTitle:[kAlphaKeyboardArray objectAtIndex:(button.tag-1)] forState:UIControlStateNormal];
            }
        }
    }
}

-(void)spaceClicked:(id)sender
{
    [self.textDocumentProxy insertText:@" "];
}

-(void)hideClicked:(id)sender
{
    [self.textDocumentProxy insertText:@"\n"];
}

-(void)keyPressed:(UIButton*)sender
{
    if([sender.titleLabel.text isEqualToString:@"٣٢١"])
    {
        for(UIButton* button in self.keyboard.ButtonArrays)
        {
            if(button.tag >=1 && button.tag <= 29)
            {
                [button setTitle:[kCharOneKeyboardArray objectAtIndex:(button.tag-1)] forState:UIControlStateNormal];
            }
        }
    }else if([sender.titleLabel.text isEqualToString:@"#+="])
    {
        for(UIButton* button in self.keyboard.ButtonArrays)
        {
            if(button.tag >=1 && button.tag <= 29)
            {
                [button setTitle:[kCharTwoKeyboardArray objectAtIndex:(button.tag-1)] forState:UIControlStateNormal];
            }
        }
    }else
    {
        [self.textDocumentProxy insertText:[sender.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

- (void)userLongPressedH:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point =  [(UIButton*)[sender view] center];
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayH
                                    delegate:self];
    }
    
}

- (void)userLongPressedY:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point = [(UIButton*)[sender view] center];
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayY
                                    delegate:self];
    }
    
}


- (void)userLongPressedL:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point = [(UIButton*)[sender view] center];
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayL
                                    delegate:self];
    }
    
}


- (void)userLongPressedA:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point = [(UIButton*)[sender view] center];
        point.y -= 50;
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayA
                                    delegate:self];
    }
    
}

- (void)userLongPressedO:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point = [(UIButton*)[sender view] center];
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayO
                                    delegate:self];
    }
    
}

- (void)userLongPressedOmlut:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        point = [(UIButton*)[sender view] center];
        point.y -= 180;
        
        pv = [PopoverView showPopoverAtPoint:point
                                      inView:self.keyboard
                             withStringArray:kStringArrayOmlut
                                    delegate:self];
    }
    
}

#pragma mark - PopoverViewDelegate Methods

-(void)popoverView:(PopoverView *)popoverView didSelectItem:(NSString *)letter
{
    
    // Show a success image, with the string from the array
    [popoverView showSuccess];
    //[popoverView showImage:[UIImage imageNamed:@"success"] withMessage:letter];
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.2f];
    [self.textDocumentProxy insertText:[letter stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView
{
    self.pv = nil;
}




@end
