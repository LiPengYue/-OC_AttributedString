//
//  NSMutableParagraphStyle+Handler.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/9/11.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableParagraphStyle (Handler)

/// 字体的行间距
- (NSMutableParagraphStyle *(^)(CGFloat spacing)) setUpLineSpacing;

///首行缩进
- (NSMutableParagraphStyle *(^)(CGFloat firstLineHeadIndent)) setUpFirstLineHeadIndent;

///（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
- (NSMutableParagraphStyle *(^)(NSTextAlignment alignment)) setUpAlignment;

///结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
- (NSMutableParagraphStyle *(^)(NSLineBreakMode lineBreakMode)) setUpLineBreakMode;

///整体缩进(首行除外)
- (NSMutableParagraphStyle *(^)(CGFloat headIndent)) setUpHeadIndent;

/// 可调整文字尾端的缩排距离。需要注意的是，这里指定的值可以当作文字显示的宽、而也可当作右边 padding 使用，依据输入的正负值而定：
- (NSMutableParagraphStyle *(^)(CGFloat tailIndent)) setUpTailIndent;

///最低行高
- (NSMutableParagraphStyle *(^)(CGFloat height)) setUpMinimumLineHeight;

///最大行高
- (NSMutableParagraphStyle *(^)(CGFloat height)) setUpMaximumLineHeight;

///段与段之间的间距
- (NSMutableParagraphStyle *(^)(CGFloat spacing)) setUpParagraphSpacing;

///段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any)and the top of this paragraph. */
- (NSMutableParagraphStyle *(^)(CGFloat spacing)) setUpParagraphSpacingBefore;


///从左到右的书写方向（一共三种）
- (NSMutableParagraphStyle *(^)(NSWritingDirection direction)) setUpBaseWritingDirection;

/**
 Natural line height is multiplied by this factor (if positive)
 before being constrained by minimum and maximum line height.
 */
- (NSMutableParagraphStyle *(^)(CGFloat height)) setUpLineHeightMultiple;

///连字属性 在iOS，唯一支持的值分别为0和1
- (NSMutableParagraphStyle *(^)(CGFloat hyphenationFactor)) setUpHyphenationFactor;

@end
