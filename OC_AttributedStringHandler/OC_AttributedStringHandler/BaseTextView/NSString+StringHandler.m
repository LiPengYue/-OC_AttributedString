//
//  NSString+StringHandler.m
//  OC_AttributedStringHandler
//
//  Created by 李鹏跃 on 2018/9/28.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "NSString+StringHandler.h"
#import <math.h>

@implementation NSString (StringHandler)

- (NSString *(^)(id objc)) addObjc {
    return ^(id objc){
        return [NSString stringWithFormat:@"%@%@",self,objc];
    };
}

- (NSString *(^)(CGFloat value, NSInteger decimalDigits, BOOL isRound)) addFloat {
    return ^(CGFloat value, NSInteger decimalDigits, BOOL isRound) {
        NSString *floatValue = [NSString createWithFloat:value
                                       andDecimalDigits:decimalDigits
                                             andIsRound:isRound];
        return [NSString stringWithFormat:@"%@%@",self,floatValue];
    };
}

- (NSString *(^)(NSInteger value)) addInt {
    return ^(NSInteger value) {
        return [NSString stringWithFormat:@"%ld",value];
    };
}

- (NSString *(^)(NSString *deleteStr)) deleteStr {
    return ^ (NSString *deleteStr) {
        NSMutableString *str = self.mutableCopy;
        [str stringByReplacingOccurrencesOfString:deleteStr withString:@""];
        return str;
    };
}

- (NSString *(^)(NSString *deleteStr)) deleteLastStr {
    return ^ (NSString *deleteStr) {
        NSMutableString *str = self.mutableCopy;
        NSInteger i = 0, length = str.length;
        for (i = length - 1; i >= 0; i--) {
           NSString *lastStr = [str substringFromIndex:str.length - 1];
            
            if ([lastStr isEqualToString:deleteStr]) {
                NSRange range = NSMakeRange(i, 1);
                [str deleteCharactersInRange:range];
                
            }else{ break; }
        }
        return str;
    };
}

- (NSString *(^)(NSString *deleteStr)) deleteFrontStr {
    return ^ (NSString *deleteStr) {
        NSMutableString *str = self.mutableCopy;
        NSInteger i, length = str.length;
        NSString *firstStr = [str substringFromIndex:0];
        for (i = 0; i < length; i++) {
            if ([firstStr isEqualToString:deleteStr]) {
                NSRange range = NSMakeRange(0, 1);
                [str deleteCharactersInRange:range];
            }
        }
        return str;
    };
}

- (NSString *(^)(void)) deleteLastChar {
    return ^ {
        NSMutableString *str = self.mutableCopy;
        NSRange range = NSMakeRange(self.length-1, 1);
        [str deleteCharactersInRange:range];
        return str;
    };
}

- (NSString *(^)(void)) deleteFrontChar {
    return ^ {
        NSMutableString *str = self.mutableCopy;
        NSRange range = NSMakeRange(0, 1);
        [str deleteCharactersInRange:range];
        return str;
    };
}

+ (NSString *) createWithFloat: (CGFloat)value
                andDecimalDigits: (NSInteger)decimalDigits
                      andIsRound: (BOOL)isRound {
    
    NSInteger decimalDigitsTemp = decimalDigits;
    CGFloat floatValue = value * (pow(10,decimalDigitsTemp));
    NSInteger integerValue = 0;
    integerValue = isRound ? round(floatValue) : floatValue;
    
    NSMutableString *strTemp = @"".mutableCopy;
    
    for (int i = 0; i < decimalDigitsTemp; i ++) {
        NSInteger value = integerValue % 10;
        
        NSString *valueStr = [NSString stringWithFormat:@"%ld",value];
        [strTemp insertString:valueStr atIndex:0];
        
        integerValue /= 10;
    }
    
    integerValue = value;
    
    return [NSString stringWithFormat:@"%ld.%@",integerValue,strTemp];
}

+ (NSString *) createWithInt: (NSInteger)value {
    return [NSString stringWithFormat:@"%ld",value];
}
@end
