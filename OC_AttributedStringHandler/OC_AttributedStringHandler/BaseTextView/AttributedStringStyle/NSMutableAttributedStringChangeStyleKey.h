//
//  NSMutableAttributedStringChangeStyleKey.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString * const k_NSMutableAttributedStringSelectedColor = @"NSMutableAttributedStringSelectedColor";

/// 单机事件注册
static NSString * const k_NSMutableAttributedStringRegisterSingleCliekWithBlock = @"k_NSMutableAttributedStringRegisterSingleCliekWithBlock";

static NSString * const k_NSMutableAttributedStringSingleClick = @"k_NSMutableAttributedStringSingleClick";

static NSString * const k_NSMutableAttributedStringSingleTarget = @"k_NSMutableAttributedStringSingleTarget";

static NSString * const k_NSMutableAttributedStringSingleData = @"k_NSMutableAttributedStringSingleData";

typedef enum {
    // NSString类型 目前只有NSTextEffectLetterpressStyle(凸版印刷效果)可用,
   NSMutableAttributedString_changeStyle_EffectEnum_LetterpressStyle
} NSMutableAttributedString_changeStyle_EffectEnum;

typedef enum {
    NSMutableAttributedString_changeStyle_LineStyleEnumSingle,
    NSMutableAttributedString_changeStyle_LineStyleEnumDouble,
    NSMutableAttributedString_changeStyle_LineStyleEnumThick,
    NSMutableAttributedString_changeStyle_LineStyleEnumNone
} NSMutableAttributedString_changeStyle_LineStyleEnum;



@interface NSMutableAttributedStringChangeStyleKey : NSObject

@end
