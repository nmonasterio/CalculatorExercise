//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Napo Monasterio on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()


@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userHasPressedTheDecimalPointButton;

@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userHasPressedTheDecimalPointButton;
@synthesize brain = _brain;


- (CalculatorBrain *)brain {
    
    if(!_brain){
        _brain = [[CalculatorBrain alloc]init];
    }
return _brain;
}





- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    
//    if (!((userHasPressedTheDecimalPointButton = YES) && ([self.display.text rangeOfString:@"."].location != NSNotFound))) {

    if(self.userIsInTheMiddleOfEnteringANumber) {
        
    self.display.text = [self.display.text stringByAppendingString:digit]; //method of NSString for concatenating
        
    }
    
    else  {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    
    }
     //&& ([) !([digit isEqualToString:@"."])
        //([self.display.text rangeOfString:@"."].location == NSNotFound)
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasPressedTheDecimalPointButton = NO;
    
}


- (IBAction)decimalPointPressed {
    if(!(self.userHasPressedTheDecimalPointButton)) {
        if(self.userIsInTheMiddleOfEnteringANumber) {
            
            self.display.text = [self.display.text stringByAppendingString:@"."]; //method of NSString for concatenating
            
        }
        
        else  {
            self.display.text = @".";
            self.userIsInTheMiddleOfEnteringANumber = YES;
            
        }
        self.userHasPressedTheDecimalPointButton = YES;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}




- (IBAction)operationPressed:(UIButton *)sender {

    if(self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
        
    
    }
    
   
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;

    self.history.text = [self.history.text stringByAppendingFormat:@"%@ %@ ", self.display.text, sender.currentTitle];
    
    NSString *historyString = self.history.text;
    
    if([historyString rangeOfString:@"="].location == NSNotFound) {
        self.history.text = [self.history.text stringByAppendingString:@" = "];
    }
    else {
        self.history.text = [self.history.text stringByReplacingOccurrencesOfString:@" = " withString:@""];
        self.history.text = [self.history.text stringByAppendingString:@" = "];
    }
    
}

- (IBAction)clearStuff {
    [self.brain clearEverything];
    self.display.text = @"0";
    self.history.text = @"";
}


- (IBAction)backspaceButton {
    if((self.display.text.length > 1)) {
    
    self.display.text = [self.display.text substringToIndex:(self.display.text.length -1)];
    }
    else {
        
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

- (IBAction)plusMinusButton {
    NSString *currentDisplay = self.display.text;
    if(self.userIsInTheMiddleOfEnteringANumber) {
        if([currentDisplay rangeOfString:@"-"].location == NSNotFound) {
            self.display.text = [NSString stringWithFormat:@"-%@", currentDisplay];
        }
        else {
            self.display.text = [self.display.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
    }
    
//    else {
//        if([currentDisplay rangeOfString:@"-"].location == NSNotFound) {
//            self.display.text = [NSString stringWithFormat:@"-%@", currentDisplay];
//            self.userIsInTheMiddleOfEnteringANumber = YES;
//            
//        }
//        else {
//            
//            self.display.text = [self.display.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            self.userIsInTheMiddleOfEnteringANumber = YES;
//
//            
//        }
//
//    }
    
}

@end
