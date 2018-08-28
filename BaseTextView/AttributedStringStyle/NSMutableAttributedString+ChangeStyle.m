//
//  NSMutableAttributedString+ChangeStyle.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "NSMutableAttributedString+ChangeStyle.h"
#import <objc/runtime.h>
NSString * const keventTarget = @"keventTarget";
@interface NSMutableAttributedString()
@property (nonatomic,weak) NSObject *eventTarget;
@end

@implementation NSMutableAttributedString (ChangeStyle)
static NSString *const k_NSMutableAttributedStringCurrenRange = @"NSMutableAttributedStringCurrenRange";
///NSForegroundColorAttributeName;// 文字颜色，value是UIFont对象
- (instancetype) foregroundColor: (UIColor *)color {
    [self addAttribute:NSForegroundColorAttributeName value:color range:[self getRange]];
    return self;
}

- (instancetype) font: (UIFont *)font {
    [self addAttribute:NSFontAttributeName value:font range:[self getRange]];
    return self;
}

///背景色，
- (instancetype) backgroundColor: (UIColor *)color {
     [self addAttribute:NSBackgroundColorAttributeName value:color range:[self getRange]];
    return self;
}

///字符连体，NSLigatureAttributeName value是NSNumber @(0) 或 @(1)
- (instancetype) ligature: (BOOL)isLigature {
     [self addAttribute:NSLigatureAttributeName value:@(isLigature) range:[self getRange]];
    return self;
}

/// 字符间隔 {NSKernAttributeName:@(4)}
- (instancetype) kern: (CGFloat)kern {
     [self addAttribute:NSKernAttributeName value:@(kern) range:[self getRange]];
    return self;
}

///NSStrikethroughStyleAttributeName;//删除线，value是NSNumber
- (instancetype) strikethroughStyle: (NSNumber *)value {
     [self addAttribute:NSStrikethroughStyleAttributeName value:value range:[self getRange]];
    return self;
}

///NSUnderlineStyleAttributeName;//下划线，value是NSNumber {NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}
- (instancetype) underlineStyle: (NSNumber *)value {
     [self addAttribute:NSUnderlineStyleAttributeName value:value range:[self getRange]];
    return self;
}

///NSStrokeColorAttributeName; //描绘边颜色，value是UIColor
- (instancetype) strokeColor: (UIColor *)color {
     [self addAttribute:NSStrokeColorAttributeName value:color range:[self getRange]];
    return self;
}

///NSStrokeWidthAttributeName; //描边宽度，value是NSNumber
- (instancetype) strokeWidth: (CGFloat) width {
     [self addAttribute:NSStrokeWidthAttributeName value:@(width) range:[self getRange]];
    return self;
}

/// 阴影，value是NSShadow对象 NSShadowAttributeName;
- (instancetype) shadow: (NSShadow *)shadow {
     [self addAttribute:NSShadowAttributeName value:shadow range:[self getRange]];
    return self;
}

///文字效果，value是NSString {NSTextEffectAttributeName:NSTextEffectLetterpressStyle}
- (instancetype) textEffect: (NSString *)effect {
     [self addAttribute:NSTextEffectAttributeName value:effect range:[self getRange]];
    return self;
}

///NSAttachmentAttributeName;//附属，value是NSTextAttachment 对象
- (instancetype) attachment: (NSTextAttachment *)value {
     [self addAttribute:NSAttachmentAttributeName value:value range:[self getRange]];
    return self;
}

///NSLinkAttributeName;//链接，value是NSURL or NSString
- (instancetype) linkString: (NSString *)string {
     [self addAttribute:NSLinkAttributeName value:string range:[self getRange]];
    return self;
}

///NSBaselineOffsetAttributeName;//基础偏移量，value是NSNumber对象
- (instancetype) baselineOffset: (CGFloat)offset {
     [self addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:[self getRange]];
    return self;
}

///NSUnderlineColorAttributeName;//下划线颜色，value是UIColor对象
- (instancetype) underLineColor: (UIColor *)color {
    [self addAttribute:NSUnderlineColorAttributeName value:color range:[self getRange]];
    return self;
}

///NSStrikethroughColorAttributeName;//删除线颜色，value是UIColor
- (instancetype) strikethroughColor: (UIColor *)color {
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:[self getRange]];
    return self;
}

///字体倾斜 {NSBaselineOffsetAttributeName:@(0)}
- (instancetype) obliqueness: (CGFloat)value {
    [self addAttribute:NSBaselineOffsetAttributeName value:@(value) range:[self getRange]];
    return self;
}

///字体扁平化 {NSExpansionAttributeName:@(1.0)}
- (instancetype) expansion: (CGFloat)value {
    [self addAttribute:NSExpansionAttributeName value:@(value) range:[self getRange]];
    return self;
}

///垂直或者水平，value是 NSNumber，0表示水平，1垂直
- (instancetype) verticalGlyph: (BOOL) isVertical { 
    [self addAttribute:NSVerticalGlyphFormAttributeName value:@(isVertical) range:[self getRange]];
    return self;
}

/// 展示风格 绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象 NSMutableParagraphStyle
- (instancetype) mutableParagraphStyle: (NSMutableParagraphStyle *)style {
    [self addAttribute:NSParagraphStyleAttributeName value:style range:[self getRange]];
    return self;
}

- (NSNumber *) getNumbserWithStyle: (NSMutableAttributedString_changeStyle_LineStyleEnum)style {
    NSNumber *styleNumbser = @0;
    switch (style) {
        case NSMutableAttributedString_changeStyle_LineStyleEnumSingle:
            styleNumbser = @(NSUnderlineStyleSingle);
            break;
        case NSMutableAttributedString_changeStyle_LineStyleEnumDouble:
            styleNumbser = @(NSUnderlineStyleDouble);
            break;
        case NSMutableAttributedString_changeStyle_LineStyleEnumThick:
            styleNumbser = @(NSUnderlineStyleThick);
            break;
        case NSMutableAttributedString_changeStyle_LineStyleEnumNone:
            styleNumbser = @(NSUnderlineStyleNone);
            break;
    }
    return styleNumbser;
}
- (instancetype) addBottomLineWithColor: (UIColor *)color
                               andStyle: (NSMutableAttributedString_changeStyle_LineStyleEnum)style {
    NSNumber *styleNumbser = [self getNumbserWithStyle:style];
    NSDictionary * attris = @{
                              NSUnderlineStyleAttributeName:styleNumbser,
                              NSUnderlineColorAttributeName:color
                              };
    
    [self addAttributes:attris range: [self getRange]];
    return self;
}

- (instancetype) strokeWithWidth: (CGFloat)w
                        andColor: (UIColor *)color {
    
    NSMutableAttributedString * mutableAttriStr = self;
    NSDictionary * attris = @{
                              NSStrokeColorAttributeName:color,
                              NSStrokeWidthAttributeName:@(w)
                              };
    NSRange range = NSMakeRange(0,mutableAttriStr.length);
    [mutableAttriStr addAttributes:attris range:range];
    return mutableAttriStr;
}


+ (instancetype) createWithImage: (UIImage *)image size: (CGSize)imageSize{
    //创建Attachment Str
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    attach.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    //添加
    NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:@""];
    [mutableAttriStr appendAttributedString:imageStr];
    return mutableAttriStr;
}
+ (instancetype) createWithImageNmae: (NSString *)name andImageSize: (CGSize)imageSize {
    UIImage *image = [UIImage imageNamed:name];
    return [self createWithImage:image size: imageSize];
}

- (NSRange) getRange {
    NSValue *value = objc_getAssociatedObject(self, &k_NSMutableAttributedStringCurrenRange);
    NSRange range = [value rangeValue];
    if (!range.length && !range.location) {
        range = NSMakeRange(0, self.length);
    }
    return range;
}

- (NSRange) getSelfRange {
    return NSMakeRange(0, self.length);
}

- (void) setRange: (NSRange)range {
    NSValue *rangeValue = [NSValue valueWithRange:range];
    objc_setAssociatedObject(self, &k_NSMutableAttributedStringCurrenRange, rangeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CFRange) getCfRange {
    return CFRangeMake(0, self.length);
}

- (instancetype) setupInRange:(NSRange)range andCallBack: (void(^)(NSMutableAttributedString *attributedStr))callBack{
    [self setRange:range];
    NSMutableAttributedString *str = [[self attributedSubstringFromRange:range] mutableCopy];
    if(callBack) {
        callBack(str);
    }
    [self replaceCharactersInRange:range withAttributedString:str];
    [self setRange: NSMakeRange(0, self.length)];
    return self;
}





- (NSMutableAttributedString *(^)(UIColor *)) color {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *color) {
        [weakSelf foregroundColor:color];
        return weakSelf;
    };
}

- (NSMutableAttributedString *(^)(UIFont *)) font {
    __weak typeof (self) weakSelf = self;
    return ^(UIFont *font) {
        [weakSelf font:font];
        return weakSelf;
    };
}

///背景色，
- (NSMutableAttributedString *(^)(UIColor *color)) backgroundColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *color) {
        [weakSelf backgroundColor:color];
        return weakSelf;
    };
}

///字符连体，NSLigatureAttributeName
- (NSMutableAttributedString *(^)(BOOL isLigature))isLigature{
    __weak typeof (self) weakSelf = self;
    return ^(BOOL isLigature) {
        [weakSelf ligature:isLigature];
        return weakSelf;
    };
}


//描绘边颜色
- (NSMutableAttributedString *(^)(UIColor *color)) strokeColor{
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *color) {
        [weakSelf strokeColor:color];
        return weakSelf;
    };
}

//描边宽度
- (NSMutableAttributedString *(^)(CGFloat width)) strokeWidth {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat width) {
        [weakSelf strokeWidth:width];
        return weakSelf;
    };
}

/// 阴影
- (NSMutableAttributedString *(^)(NSShadow *shadow)) shadow {
    __weak typeof (self) weakSelf = self;
    return ^(NSShadow *shadow) {
        [weakSelf shadow:shadow];
        return weakSelf;
    };
}

/// 字体效果
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_EffectEnum effect)) textEffect {
    __weak typeof (self) weakSelf = self;
    return ^(NSMutableAttributedString_changeStyle_EffectEnum effect) {
        NSString *effectStr;
        switch (effect) {
            case NSMutableAttributedString_changeStyle_EffectEnum_LetterpressStyle:
                effectStr = NSTextEffectLetterpressStyle;
                break;
        }
        [weakSelf textEffect:effectStr];
        return weakSelf;
    };
}
- (NSMutableAttributedString *(^)(NSTextAttachment *attachment)) attachment {
    __weak typeof (self) weakSelf = self;
    return ^(NSTextAttachment *attachment) {
        [weakSelf attachment:attachment];
        return weakSelf;
    };
}
///基础偏移量
- (NSMutableAttributedString *(^)(CGFloat offset)) baselineOffset {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat offset) {
        [weakSelf baselineOffset:offset];
        return weakSelf;
    };
}

///下划线颜色
- (NSMutableAttributedString *(^)(UIColor *color)) underLineColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *color) {
        [weakSelf underLineColor:color];
        return weakSelf;
    };
}

/// 删除线颜色
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_LineStyleEnum style, UIColor *color,NSNumber *OffsetAttributeName))strikethrough {
    __weak typeof (self) weakSelf = self;
    return ^(NSMutableAttributedString_changeStyle_LineStyleEnum style, UIColor *color,NSNumber *OffsetAttributeName) {
        NSNumber *styleNumbser = [self getNumbserWithStyle:style];
        NSDictionary *dic = @{
          NSStrikethroughStyleAttributeName : styleNumbser,
          NSStrikethroughColorAttributeName : color,
          NSBaselineOffsetAttributeName : OffsetAttributeName
          };
        
        [weakSelf addAttributes:dic range:[weakSelf getRange]];
        return weakSelf;
    };
}

/// 字体倾斜度
- (NSMutableAttributedString *(^)(CGFloat obliqueness)) obliqueness {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat obliqueness) {
        [weakSelf obliqueness:obliqueness];
        return weakSelf;
    };
}

///字体扁平化 {NSExpansionAttributeName:@(1.0)}
- (NSMutableAttributedString *(^)(CGFloat expansion)) expansion {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat expansion) {
        [weakSelf expansion:expansion];
        return weakSelf;
    };
}

///垂直或者水平，value是 NSNumber，0表示水平，1垂直
- (NSMutableAttributedString *(^)(BOOL isVertical)) isVertical {
    __weak typeof (self) weakSelf = self;
    return ^(BOOL isVertical) {
        [weakSelf verticalGlyph:isVertical];
        return weakSelf;
    };
}

/// 展示风格 绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象 NSMutableParagraphStyle
- (NSMutableAttributedString *(^)(NSMutableParagraphStyle *style)) mutableParagraphStyle {
    __weak typeof (self) weakSelf = self;
    return ^(NSMutableParagraphStyle *style) {
        [weakSelf mutableParagraphStyle:style];
        return weakSelf;
    };
}



- (NSMutableAttributedString *(^)(NSString *)) link {
    __weak typeof (self) weakSelf = self;
    return ^(NSString *link) {
        [weakSelf linkString:link];
        return weakSelf;
    };
}

- (NSMutableAttributedString *(^)(CGFloat)) kern {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat kern) {
        [weakSelf kern:kern];
        return weakSelf;
    };
}


- (NSMutableAttributedString *(^)(SingleCallBack singleCallBack)) registerSingleClick {
     __weak typeof (self) weakSelf = self;
    return ^(SingleCallBack singleCallBack) {
        if (singleCallBack) {
            [weakSelf addAttribute:k_NSMutableAttributedStringRegisterSingleCliekWithBlock value:singleCallBack range:[weakSelf getRange]];
        }
        return weakSelf;
    };
}

/**
 * @brief 添加下划线
 * @return 返回self.
 */
- (NSMutableAttributedString *(^)(NSMutableAttributedString_changeStyle_LineStyleEnum style, UIColor *color)) addBottomLine {
    __weak typeof (self) weakSelf = self;
    return ^(NSMutableAttributedString_changeStyle_LineStyleEnum style,UIColor *color) {
        [weakSelf addBottomLineWithColor:color andStyle:style];
        return weakSelf;
    };
}

/// 描边
- (NSMutableAttributedString *(^)(CGFloat width, UIColor *color)) stroke {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat width, UIColor *color) {
        [weakSelf strokeWithWidth:width andColor:color];
        return weakSelf;
    };
}





//- (NSMutableAttributedString *(^)(SEL, NSObject *target, NSObject *data)) singleClick {
//    __weak typeof (self) weakSelf = self;
//    return ^(SEL selecter, NSObject *target, NSObject *data) {
//
//        NSLog(@"str指针内存地址：%x",&target);
//        NSLog(@"str指针所指向对象的地址：%p\n",target);
//        NSString *selecterStr = NSStringFromSelector(selecter);
//
//        [weakSelf addAttribute:k_NSMutableAttributedStringSingleClick value:selecterStr range:[weakSelf getRange]];
//
//        [weakSelf addAttribute:k_NSMutableAttributedStringSingleData value:data range:[weakSelf getRange]];
//
//        //MARK: - 出现循环引用问题
//        [weakSelf addAttribute:k_NSMutableAttributedStringSingleTarget value:target range:[weakSelf getRange]];
//        return weakSelf;
//    };
//}


//- (NSMutableAttributedString *(^)(NSObject *))target {
//    __weak typeof (self) weakSelf = self;
//    return ^(NSObject *obj){
//        NSLog(@"%@",obj);
////        [weakSelf addAttribute:@"qq" value:obj range: [weakSelf getRange]];
////        weakSelf.eventTarget = obj;
//        return weakSelf;
//    };
//}
//- (NSMutableAttributedString *) test:(NSObject *)obj; {
//    NSLog(@"test 指针内存地址：%x",&obj);
//    NSLog(@"test 指针所指向对象的地址：%p\n",obj);
//    return self;
//}



// MARK: - set && get

//- (void) setEventTarget:(NSObject *)eventTarget {
//
//    objc_setAssociatedObject(self, &keventTarget, eventTarget, OBJC_ASSOCIATION_ASSIGN);
//    if (self.eventTarget) {
//        __weak typeof(self.eventTarget) weakEvent = self.eventTarget;
//    }
//}
//- (NSObject *) eventTarget {
//    return objc_getAssociatedObject(self, &keventTarget);
//}
@end

