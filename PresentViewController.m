//
//  PresentViewController.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "PresentViewController.h"
#import "BaseTextView.h"

@interface PresentViewController ()
@property (nonatomic,strong) BaseTextView *textView;
@end

@implementation PresentViewController
- (NSString *)getString {
    return @"$哈$哈*哈<哈>#哈哈哈哈哈#哈哈哈哈哈#哈哈哈$哈$哈哈哈$哈哈$哈哈哈哈哈哈$哈哈哈#哈哈哈#哈#哈哈#哈哈哈#哈哈哈,<哈哈<哈>#哈哈哈哈#哈哈哈哈哈哈哈哈哈哈或或或或或或#哈哈哈哈哈#或或或或或heh";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"str指针内存地址：%x",&self);
    NSLog(@"str指针所指向对象的地址：%p\n",self);
    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc]initWithString: [self getString]];
    
    
    NSRange ragne1 = NSMakeRange(0, attributedStringM.length);
    [attributedStringM setupInRange: ragne1 andCallBack:^(NSMutableAttributedString *str) {
        str
        .color([UIColor grayColor])
        .font([UIFont systemFontOfSize:23]);
    }];
    
    NSArray <AttributedStrFiltrateRuler *>*array = [attributedStringM filtrates:[self createRulers]];
    __weak typeof(self) weakSelf = self;
    for (AttributedStrFiltrateRuler *ruler in array) {
        
        [ruler.textCheckingResultArray enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableAttributedString_changeStyle_LineStyleEnum lineStyle = NSMutableAttributedString_changeStyle_LineStyleEnumDouble;
            NSShadow *shadow = [[NSShadow alloc]init];
            shadow.shadowOffset = CGSizeMake(3, 3);
            shadow.shadowColor = [UIColor blueColor];
            shadow.shadowBlurRadius =10;
            
            [attributedStringM setupInRange:obj.range andCallBack:^(NSMutableAttributedString *attributedStr) {
                
                attributedStr
                .color(ruler.color)
                .font([UIFont systemFontOfSize:30])
                .isLigature(true)
                .kern(12)
                .backgroundColor([UIColor lightGrayColor])
                .strikethrough(lineStyle, [UIColor blueColor],@0)
                .stroke(1,[UIColor blueColor])
                .shadow(shadow)
                .addBottomLine(lineStyle,[UIColor redColor])
                .registerSingleClick(^{
                    attributedStringM.font([UIFont systemFontOfSize:20]);
                    [weakSelf dismissViewControllerAnimated:true completion:nil];
                });
            }];
        }];
        
    }

    
    UILabel *label = [[UILabel alloc]init];
    CGRect rect = self.view.bounds;
    rect.origin.y -= 40;
    rect.size.height -= 40;
    label.frame = rect;
    [self.view addSubview:label];
    
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.attributedText = attributedStringM;
    
//    self.textView.frame = CGRectMake(10, 100, 300, 500);
//    [self.view addSubview:self.textView];
//    self.textView.attributedStr = attributedStringM;
    self.view.backgroundColor = [UIColor grayColor];
}

- (BaseTextView *)textView {
    if (!_textView) {
        _textView = [[BaseTextView alloc]init];
    }
    return _textView;
}

- (void) click: (NSObject *)data {
    NSLog(@"str指针内存地址：%x",&self);
    NSLog(@"str指针所指向对象的地址：%p\n",self);
    [self dismissViewControllerAnimated:false completion:nil];
}

- (void)dealloc {
    NSLog(@"✅ ： %@",self);
}

- (NSArray <AttributedStrFiltrateRuler *>*) createRulers {
    AttributedStrFiltrateRuler *ruler = [AttributedStrFiltrateRuler new];
    ruler.expressionString = @"#哈哈哈哈哈#";
    ruler.color = [UIColor redColor];
    
    
    AttributedStrFiltrateRuler *ruler1 = [AttributedStrFiltrateRuler new];
    ruler1.expressionString = @"<哈>";
    ruler1.color = [UIColor blueColor];
    return @[ruler,ruler1];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self dismissViewControllerAnimated:true completion:nil];
//}
@end





