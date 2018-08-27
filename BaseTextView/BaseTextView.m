//
//  BaseTextView.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "BaseTextView.h"
#import "NSMutableAttributedString+ChangeStyle.h"

@interface BaseTextView ()
@property (nonatomic,assign) BOOL isFirstLayout;
@property (nonatomic,assign) CTFramesetterRef ctFramesetter;
@property (nonatomic,assign) CTFrameRef ctFrame;
/// 存放的 CGRect
@property (nonatomic,strong) NSMutableArray <NSValue*>* textFrameArray;
@end

@implementation BaseTextView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



#pragma mark - functions
- (void) setup {
    
}

- (void) updateDisplay {
    [self setNeedsDisplay];
}

- (CFIndex) touchContentOffsetPoint:(CGPoint)point
                            frameRef:(CTFrameRef)frameRef{
    
    NSArray * arrLines = (NSArray *)CTFrameGetLines(self.ctFrame);
    if (!arrLines) {
        return -1;
    }
    CFIndex count = arrLines.count;
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0,0), origins);
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = (__bridge CTLineRef)(arrLines[i]);
        // 获得每一行的CGRect信息
        CGRect flippedRect = [self getLineBounds:line
                                           point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        if (CGRectContainsPoint(rect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
                                                point.y-CGRectGetMinY(rect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
            
        }
    }
    NSLog(@"%ld",idx);
    return idx;
}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

-(void)handleActiveRectWithFrame:(CTFrameRef)frame
{
    //根据frame获取需要绘制的线的数组
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    //获取线的数量
    NSInteger count = [arrLines count];
    //建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CGPoint points[count];
    //获取起点
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    //遍历线的数组
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        //获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
        NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
        //遍历CTRun数组
        for (int j = 0; j < arrGlyphRun.count; j ++) {
            //获取CTRun
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
            //获取CTRun的属性
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            //获取代理
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            //获取一个起点
            CGPoint point = points[i];
            //判断是否图片，不是图片判断是否活跃文字
            if (delegate == nil) {
                NSString * string = attributes[k_NSMutableAttributedStringSingleClick];
                if (string) {
                    [self.textFrameArray addObject:[NSValue valueWithCGRect:[self getLocWithFrame:frame CTLine:line CTRun:run origin:point]]];
                }
                continue;
            }
            //判断代理字典
            NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
        }
    }
}

-(CGRect)getLocWithFrame:(CTFrameRef)frame CTLine:(CTLineRef)line CTRun:(CTRunRef)run origin:(CGPoint)origin
{
    CGFloat ascent;//获取上距
    CGFloat descent;//获取下距
    CGRect boundsRun;//创建一个frame
    
    boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
    boundsRun.size.height = ascent + descent;
    CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);//获取x偏移量
    boundsRun.origin.x = origin.x + xOffset;//point是行起点位置，加上每个字的偏移量得到每个字的x
    boundsRun.origin.y = origin.y - descent;
    
    CGPathRef path = CTFrameGetPath(frame);//获取绘制区域
    CGRect colRect = CGPathGetBoundingBox(path);//获取剪裁区域边框
    CGRect deleteBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);//获取绘制区域
    return deleteBounds;
}

- (CTFramesetterRef) getCtFramesetter {
    CFAttributedStringRef str = (__bridge CFAttributedStringRef)self.attributedStr;
    return CTFramesetterCreateWithAttributedString(str);
}

- (CTFrameRef) getCtFrameWithFramesetter: (CTFramesetterRef)framesetter {
    
    CFRange range = [self.attributedStr getCfRange];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    
    return CTFramesetterCreateFrame(framesetter, range, path.CGPath, nil);
}

///将系统坐标转换为屏幕坐标
-(CGRect)convertRectFromLoc:(CGRect)rect
{
    return CGRectMake(rect.origin.x,
                      
                      self.bounds.size.height
                      - rect.origin.y
                      - rect.size.height,
                      
                      rect.size.width,
                      rect.size.height);
}

// MARK: network


// MARK: handle views



// MARK: handle event
// MARK: properties get && set
- (void) setAttributedStr:(NSMutableAttributedString *)attributedStr {
    _attributedStr = attributedStr;
    self.ctFramesetter = [self getCtFramesetter];
    self.ctFrame = [self getCtFrameWithFramesetter: _ctFramesetter];
    [self setNeedsDisplay];
}


- (void) setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame) CFRelease(_ctFrame);
    _ctFrame = ctFrame;
}

- (void) setCtFramesetter:(CTFramesetterRef)ctFramesetter {
    if (_ctFramesetter) CFRelease(_ctFramesetter);
    _ctFramesetter = ctFramesetter;
}

- (NSMutableArray<NSValue *> *)textFrameArray {
    if (!_textFrameArray) {
        _textFrameArray = [NSMutableArray new];
    }
    return _textFrameArray;
}


// MARK:life cycles

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    [self handleActiveRectWithFrame:self.ctFrame];
    
    CTFrameDraw(self.ctFrame, context);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.frame.size.width <= 0) {
        return;
    }
    if(!self.isFirstLayout) {
        return;
    }
    self.isFirstLayout = false;
}

-(void)dealloc {
    Class classStr = [self class];
    NSLog(@"✅ ： %@",classStr);
    CFRelease(self.ctFrame);
    CFRelease(self.ctFramesetter);
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    // 获取 index
    CFIndex index = [self touchContentOffsetPoint:location frameRef:self.ctFrame];
    
    if (index < 0 || index > self.attributedStr.length) {
        return;
    }
            
    /// 点击范围
    NSRange range = NSMakeRange(0, 1);
    
   NSDictionary <NSString *,id> *attributes = [self.attributedStr attributesAtIndex:index effectiveRange:&range];
    SingleCallBack block = attributes[k_NSMutableAttributedStringRegisterSingleCliekWithBlock];
    if (block) {
        block();
    }
    
    NSObject *targate = attributes[k_NSMutableAttributedStringSingleTarget];
    NSObject *data = attributes[k_NSMutableAttributedStringSingleData];
    NSString *func = attributes[k_NSMutableAttributedStringSingleClick];
    
    if (!targate || !func) {
        return;
    }
    
    SEL sel = NSSelectorFromString(func);
    IMP imp = [targate methodForSelector:sel];
    
    if (![targate respondsToSelector:sel]) {
        return;
    }
    
    void (*function)(id, SEL,NSObject *) = (void *)imp;
    function(targate, sel,data);
}

@end

