//
//  BaseLabel.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableAttributedString+ChangeStyle.h"

@interface BaseLabel : UILabel
@property (nonatomic,strong) NSMutableAttributedString *attributedStr;
@end
