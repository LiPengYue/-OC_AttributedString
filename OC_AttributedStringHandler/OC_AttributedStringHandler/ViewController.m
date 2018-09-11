//
//  ViewController.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "NSMutableParagraphStyle+Handler.h"
#import "NSMutableAttributedString+ChangeStyle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.frame = self.view.bounds;
    
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [UILabel new];
    label.frame = self.view.bounds;
    [self.view addSubview:label];
    label.numberOfLines = 3;
    
    NSString *str = @"fifififififififififfififififififfi打死啦地开发；案例给客户当时阿萨德；了工卡是递归；了动画撒个asdgasdgadsgsadg";
    NSMutableAttributedString *attristr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    
    style
    .setUpLineSpacing(12)
    .setUpFirstLineHeadIndent(121)
    .setUpHyphenationFactor(0)
    .setUpLineBreakMode(NSLineBreakByTruncatingTail);
    
    attristr
    .setUpKern(11)
    .setUpFont([UIFont systemFontOfSize:20])
    .setUpColor([UIColor redColor])
    .setUpIsLigature(true)
    .setUpMutableParagraphStyle(style);
    label.attributedText = attristr;
}
- (void)click {
    PresentViewController *vc = [PresentViewController new];
    [self presentViewController:vc animated:true completion:nil];
}

//- (void)a: (NSString *)str {
//    NSLog(@"str指针内存地址：%x",&str);
//    NSLog(@"str指针所指向对象的地址：%p\n",str);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end




