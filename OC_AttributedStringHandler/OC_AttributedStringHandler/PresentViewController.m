//
//  PresentViewController.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/27.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "PresentViewController.h"
#import "BaseTextView.h"
#import "BaseLabel.h"
#import "NSMutableParagraphStyle+Handler.h"

@interface PresentViewController ()
@property (nonatomic,strong) BaseTextView *textView;
@end

@implementation PresentViewController
- (NSString *)getString {
    return @"$哈$哈*哈<哈>#哈哈哈哈哈#哈哈哈哈哈#哈哈哈$哈$哈哈哈$哈哈$哈哈哈哈哈哈$哈哈哈#哈哈哈#哈#哈哈#哈哈哈#哈哈哈,<哈哈<哈>#哈哈哈哈#哈哈哈哈哈哈哈哈哈哈或或或或或或#哈哈哈哈哈#或或或或或hfjhalfieh$哈$哈*哈<哈>#哈哈哈哈哈#哈哈哈哈哈#哈哈哈$哈$哈哈哈$哈哈$哈哈哈哈哈哈$哈哈哈#哈哈哈#哈#哈哈#哈哈哈#哈哈";
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc]initWithString: [self getString]];
    
    
    NSRange ragne1 = NSMakeRange(0, attributedStringM.length);
    
    [attributedStringM setupInRange: ragne1 andCallBack:^(NSMutableAttributedString *str) {
        str
        .setUpColor([UIColor grayColor])
        .setUpFont([UIFont systemFontOfSize:23]);
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
                .setUpColor(ruler.color)
                .setUpFont([UIFont systemFontOfSize:30])
                .setUpIsLigature(true)
                .setUpKern(12)
                .setUpBackgroundColor([UIColor lightGrayColor])
                .setUpStrikethrough(lineStyle, [UIColor blueColor],@0)
                .setUpStroke(1,[UIColor blueColor])
                .setUpShadow(shadow)
                .setUpAddBottomLine(lineStyle,[UIColor redColor])
                .setUpRegisterSingleClick(^{
                    attributedStringM.setUpFont([UIFont systemFontOfSize:40]);
                    [weakSelf dismissViewControllerAnimated:true completion:nil];
                });
            }];
        }];
    }

    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    style
    .setUpLineSpacing(16)
    .setUpFirstLineHeadIndent(3)
    .setUpLineBreakMode(NSLineBreakByTruncatingMiddle)
    .setUpFirstLineHeadIndent(10);
    
    attributedStringM.setUpMutableParagraphStyle(style);
    
    
    [attributedStringM addAttribute:@"aa" value:self range:[attributedStringM range]];
    
    NSMutableAttributedString *attributedImageStr = [NSMutableAttributedString createWithImage:[UIImage imageNamed:@"1"] size:CGSizeMake(40, 140)];
    attributedImageStr.setUpFont([UIFont systemFontOfSize:40 weight:140]);

    
    CGRect rect = self.view.bounds;
//    rect.origin.y += 40;
//    rect.origin.x += 50;
//    rect.size.height -= 80;
//    rect.size.width -= 100;
    
    
    BaseLabel *label = [[BaseLabel alloc]init];
    label.frame = rect;
    [self.view addSubview:label];
    label.userInteractionEnabled = true;
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.attributedText = attributedStringM;
    CGFloat height = 100;

//    label.maxWidth = self.view.frame.size.width;
//    height = label.currentTextSize.height;
//
//    [label reloadFramestter];
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (BaseTextView *)textView {
    if (!_textView) {
        _textView = [[BaseTextView alloc]init];
    }
    return _textView;
}

- (void) click: (NSObject *)data {

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





