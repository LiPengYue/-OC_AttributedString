//
//  BaseTextView.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "NSMutableAttributedString+ChangeStyle.h"
#import "NSAttributedString+FiltrateRuler.h"


@interface BaseTextView : UIView
@property (nonatomic,strong) NSMutableAttributedString *attributedStr;
- (void) updateDisplay;
@end
