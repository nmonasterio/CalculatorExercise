//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Napo Monasterio on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end


@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack {
    
    
    //lazy instantiation. This means operandStack will never be nil
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc]init];
        
    
    return _operandStack;
}

-(void)setOperandStack:(NSMutableArray *)operandStack {
        _operandStack = operandStack;
}

-(void)pushOperand:(double)operand {
    
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
    }

-(double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    
    if(operandObject) {
    [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
    
}

-(double)performOperation:(NSString *)operation {
    
    double result = 0;
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];   
    }
    else if([operation isEqualToString:@"-"]) {
        double substrahend = [self popOperand];
        result = [self popOperand] - substrahend;   
    }
    
    else if([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];   
    }
    
    else if([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if(divisor) {
                result = [self popOperand] / divisor;   
        }
        else {
            result = 0;
        }
    }
    

    
    else if([operation isEqualToString:@"cos"]) {
        double cosine = [self popOperand];
        result = cos(cosine);   
    }
    
    else if([operation isEqualToString:@"sin"]) {
        double dblSin = [self popOperand];
        result = sin(dblSin);
    }
    
    else if([operation isEqualToString:@"sqrt"]) {
        double squareRoot = [self popOperand];
        result = sqrt(squareRoot);
    }
    
    else if([operation isEqualToString:@"π"]) {
        result = M_PI;
    }
    else if([operation isEqualToString:@"e"]) {
        double exp = [self popOperand];
        result = exp * exp;
    }
    
    [self pushOperand:result];
    
    return result;
}

-(void)clearEverything {
    if (_operandStack) {
    [self.operandStack removeAllObjects];  
    }
    
}


@end
