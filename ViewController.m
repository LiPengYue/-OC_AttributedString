//
//  ViewController.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.frame = self.view.bounds;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
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




