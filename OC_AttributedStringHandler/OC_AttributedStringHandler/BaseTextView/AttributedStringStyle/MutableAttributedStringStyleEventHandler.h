//
//  MutableAttributedStringStyleEventHandler.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutableAttributedStringStyleEventHandler : NSObject
- (MutableAttributedStringStyleEventHandler *(^)(SEL event)) singleClick;

- (NSMutableAttributedString *)data;
@end
