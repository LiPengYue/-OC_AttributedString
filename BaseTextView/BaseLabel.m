//
//  BaseLabel.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "BaseLabel.h"

@interface BaseLabel ()
@property (nonatomic,assign) CTFramesetterRef ctFramesetter;
@property (nonatomic,assign) CTFrameRef ctFrame;
@end


@implementation BaseLabel
@synthesize ctFramesetter = _ctFramesetter, ctFrame = _ctFrame;
#pragma mark - init

#pragma mark - functions

- (void) setup {
    
}

// MARK: network



// MARK: handle views



// MARK: handle event


// MARK: properties get && set

- (CTFramesetterRef) ctFramesetter {
    if (!_ctFramesetter) {
        CFAttributedStringRef str = (__bridge CFAttributedStringRef)self.attributedStr;
        _ctFramesetter = CTFramesetterCreateWithAttributedString(str);
    }
    return _ctFramesetter;
}

- (CTFrameRef) ctFrame {
    if (!_ctFrame) {
        CFRange range = [self.attributedStr getCfRange];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        
        _ctFrame = CTFramesetterCreateFrame(self.ctFramesetter, range, path.CGPath, nil);
    }
    return _ctFrame;
}

- (void) setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame) CFRelease(_ctFrame);
    _ctFrame = ctFrame;
}

- (void) setCtFramesetter:(CTFramesetterRef)ctFramesetter {
    if (_ctFramesetter) CFRelease(_ctFramesetter);
    _ctFramesetter = ctFramesetter;
}

// MARK:life cycles
-(void)dealloc {
    Class classStr = [self class];
    NSLog(@"✅ ： %@",classStr);
    CFRelease(self.ctFrame);
    CFRelease(self.ctFramesetter);
}

//- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    [super touchesBegan:touches withEvent:event];
//
//    UITouch * touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//
//    // 获取 index
//    CFIndex index = [self touchContentOffsetPoint:location frameRef:self.ctFrame];
//
//    if (index < 0 || index > self.attributedStr.length) {
//        return;
//    }
//
//    /// 点击范围
//    NSRange range = NSMakeRange(0, 1);
//
//    NSDictionary <NSString *,id> *attributes = [self.attributedStr attributesAtIndex:index effectiveRange:&range];
//    SingleCallBack block = attributes[k_NSMutableAttributedStringRegisterSingleCliekWithBlock];
//    if (block) {
//        block();
//    }
//
//    NSObject *targate = attributes[k_NSMutableAttributedStringSingleTarget];
//    NSObject *data = attributes[k_NSMutableAttributedStringSingleData];
//    NSString *func = attributes[k_NSMutableAttributedStringSingleClick];
//
//    if (!targate || !func) {
//        return;
//    }
//
//    SEL sel = NSSelectorFromString(func);
//    IMP imp = [targate methodForSelector:sel];
//
//    if (![targate respondsToSelector:sel]) {
//        return;
//    }
//
//    void (*function)(id, SEL,NSObject *) = (void *)imp;
//    function(targate, sel,data);
//}
//
@end

