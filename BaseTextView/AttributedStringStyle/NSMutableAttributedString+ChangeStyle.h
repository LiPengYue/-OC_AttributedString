//
//  NSMutableAttributedString+ChangeStyle.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "AttributedStrFiltrateRuler.h"
#import "NSMutableAttributedStringChangeStyleKey.h"

typedef void(^SingleCallBack)(void);

@interface NSMutableAttributedString (ChangeStyle)

+ (instancetype) createWithImageNmae: (NSString *)name;
+ (instancetype) createWithImage: (UIImage *)image;
- (NSRange) getSelfRange;
- (CFRange) getCfRange;

/**
 * @brief 添加下划线
 *
 * @param  color 颜色.
 * @param  style NSUnderlineStyleSingle、 NSUnderlineStyleDouble、 NSUnderlineStyleThick、NSUnderlineStyleNone
 *
 * @return 返回self.
 */
- (instancetype) addBottomLineWithColor: (UIColor *)color
                               andStyle: (NSMutableAttributedString_changeStyle_LineStyleEnum)style;

- (instancetype) strokeWithWidth: (CGFloat)w
                        andColor: (UIColor *)color;


//MARK: - 链式调用
/// 设置 AttributedString 指定range的属性
- (instancetype) setupInRange:(NSRange)range andCallBack: (void(^)(NSMutableAttributedString *attributedStr))callBack;

/// 设置text foregroundColor
- (NSMutableAttributedString *(^)(UIColor *)) color;
/// 设置font
- (NSMutableAttributedString *(^)(UIFont *)) font;
/// 添加link
- (NSMutableAttributedString *(^)(NSString *)) link;
/// 字间距
- (NSMutableAttributedString *(^)(CGFloat)) kern;
///背景色，
- (NSMutableAttributedString *(^)(UIColor *color)) backgroundColor;
///字符连体，NSLigatureAttributeName
- (NSMutableAttributedString *(^)(BOOL isLigature))isLigature;
//描绘边颜色
- (NSMutableAttributedString *(^)(UIColor *color)) strokeColor;
//描边宽度
- (NSMutableAttributedString *(^)(CGFloat width)) strokeWidth;
/// 阴影
- (NSMutableAttributedString *(^)(NSShadow *shadow)) shadow;
/// 字体效果
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_EffectEnum effect)) textEffect;
- (NSMutableAttributedString *(^)(NSTextAttachment *attachment)) attachment;
///基础偏移量
- (NSMutableAttributedString *(^)(CGFloat offset)) baselineOffset;
///下划线颜色
- (NSMutableAttributedString *(^)(UIColor *color)) underLineColor;
/// 删除线
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_LineStyleEnum style, UIColor *color,NSNumber *OffsetAttributeName))strikethrough;
/// 字体倾斜度
- (NSMutableAttributedString *(^)(CGFloat obliqueness)) obliqueness;

///字体扁平化 {NSExpansionAttributeName:@(1.0)}
- (NSMutableAttributedString *(^)(CGFloat expansion)) expansion;

///垂直或者水平，value是 NSNumber，0表示水平，1垂直
- (NSMutableAttributedString *(^)(BOOL isVertical)) isVertical;

/// 展示风格 绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象 NSMutableParagraphStyle
- (NSMutableAttributedString *(^)(NSMutableParagraphStyle *style)) mutableParagraphStyle;

/**
 * @brief 添加下划线
 * color 颜色.  style
 * @return 返回self.
 */
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_LineStyleEnum style, UIColor *color)) addBottomLine;

/// 描边
- (NSMutableAttributedString *(^)(CGFloat width, UIColor *color)) stroke;

/**
 * @brief    简要描述.
 *
 * 详细描述或其他.
 * @warning 警告:中间的代码在引用外部的变量的时候，需要用weak修饰 否则会导致循环引用
 *
 * 代码:
 *
 *     [NSMutebleAttributedString 对象]
 *     .registerSingleClick(^{
 *      注意中间引用对象 需要用weak修饰
 *      [weakSelf singleEventFunc];
 *      });
 */
- (NSMutableAttributedString *(^)(SingleCallBack singleCallBack)) registerSingleClick;


// MARK: - 对象方法
///NSForegroundColorAttributeName;// 文字颜色，
- (instancetype) foregroundColor: (UIColor *)color;

- (instancetype) font: (UIFont *)font;
///背景色，
- (instancetype) backgroundColor: (UIColor *)color;

///字符连体，NSLigatureAttributeName value是NSNumber @{0} 或 @{1}
- (instancetype) ligature: (BOOL)isLigature;

/// 字符间隔 {NSKernAttributeName:@(4)}
- (instancetype) kern: (CGFloat)kern;

///NSStrikethroughStyleAttributeName;//删除线，value是NSNumber
- (instancetype) strikethroughStyle: (NSNumber *)value;

///NSUnderlineStyleAttributeName;//下划线，value是NSNumber
- (instancetype) underlineStyle: (NSNumber *)value;

///NSStrokeColorAttributeName; //描绘边颜色，value是UIColor
- (instancetype) strokeColor: (UIColor *)color;

///NSStrokeWidthAttributeName; //描边宽度，value是NSNumber
- (instancetype) strokeWidth: (CGFloat) width;

/// 阴影，value是NSShadow对象 NSShadowAttributeName;
- (instancetype) shadow: (NSShadow *)shadow;

///文字效果，value是NSString {NSTextEffectAttributeName:NSTextEffectLetterpressStyle}
- (instancetype) textEffect: (NSString *)effect;

///NSAttachmentAttributeName;//附属，value是NSTextAttachment 对象
- (instancetype) attachment: (NSTextAttachment *)value;

///NSLinkAttributeName;//链接，value是NSURL or NSString
- (instancetype) linkString: (NSString *)string;

///NSBaselineOffsetAttributeName;//基础偏移量，value是NSNumber对象
- (instancetype) baselineOffset: (CGFloat)offset;

///NSUnderlineColorAttributeName;//下划线颜色，value是UIColor对象
- (instancetype) underLineColor: (UIColor *)color;

///NSStrikethroughColorAttributeName;//删除线颜色，value是UIColor
- (instancetype) strikethroughColor: (UIColor *)color;

///字体倾斜 {NSBaselineOffsetAttributeName:@(0)}
- (instancetype) obliqueness: (CGFloat)value;

///字体扁平化 {NSExpansionAttributeName:@(1.0)}
- (instancetype) expansion: (CGFloat)value;

///垂直或者水平，value是 NSNumber，0表示水平，1垂直
- (instancetype) verticalGlyph: (BOOL) isVertical;
/// 展示风格 绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象 NSMutableParagraphStyle
- (instancetype) mutableParagraphStyle: (NSMutableParagraphStyle *)style;

@end
