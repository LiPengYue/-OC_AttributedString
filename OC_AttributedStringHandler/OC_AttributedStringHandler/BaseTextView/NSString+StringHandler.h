//
//  NSString+StringHandler.h
//  OC_AttributedStringHandler
//
//  Created by 李鹏跃 on 2018/9/28.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (StringHandler)


/**
 添加objc对象
 · 参数为id类型
 */
- (NSString *(^)(id objc)) addObjc;


/**
 返回拼接float后的字符串
 · 第一个参数： float
 · 第二个参数： 保留几位小数
 · 第三个参数： 是否四舍五入
 */
- (NSString *(^)(CGFloat value,
                 NSInteger decimalDigits,
                 BOOL isRound)) addFloat;


/**
 添加int字符
 */
- (NSString *(^)(NSInteger value)) addInt;


- (NSString *(^)(NSString *deleteStr)) deleteStr;

/**
 * @brief 从后开始遍历删除指定字符
 * @ 参数为 string
 * @return 返回str.
 */
- (NSString *(^)(NSString *deleteStr)) deleteLastStr;

/**
 * @brief 从前开始遍历删除指定字符
 * @ 参数为 string
 * @return 返回str.
 */
- (NSString *(^)(NSString *deleteStr)) deleteFrontStr;

/**
 * @brief 删除最后一个字符 @ 参数为 void
 */
- (NSString *(^)(void)) deleteLastChar;

/**
 * @brief 删除第一个字符 @ 参数为 void
 */
- (NSString *(^)(void)) deleteFrontChar;




/**
 float 转成字符串
 
 @param value float值
 @param decimalDigits 保留几位小数
 @param isRound 四舍五入或者直接去掉最后的小数
 @return string
 */
+ (NSString *) createWithFloat: (CGFloat)value
                andDecimalDigits: (NSInteger)decimalDigits
                      andIsRound: (BOOL)isRound;

+ (NSString *) createWithInt: (NSInteger)value;
@end
