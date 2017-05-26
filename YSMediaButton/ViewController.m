//
//  ViewController.m
//  Demo_02
//
//  Created by Milton on 17/5/7.
//  Copyright © 2017年 YueShi. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "YSMediaButton.h"

@interface ViewController ()<YSMediaButtonDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong)YSMediaButton *button;

@property (nonatomic, strong)UIView *backView;

@end

@implementation ViewController
{
    NSTimeInterval _currentTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    _backView.userInteractionEnabled = YES;
    [_backView addGestureRecognizer:tap];
    [self.view addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    _button = [[YSMediaButton alloc]init];
    _button.touchDelegate = self;
    _button.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
}

- (void)tapAction{
    NSLog(@"111111");
}

-(NSTimeInterval)ys_getTotalTime{
    return 5999;
}
-(NSTimeInterval)ys_getPlayerCurrentTime{
    return _currentTime;
}
-(void)ys_touchesEndMoveActionCurrentTime:(NSTimeInterval)currentTime{
    _currentTime = currentTime;
}
-(void)ys_touchesMovingActionCurrentTime:(NSTimeInterval)currentTime{
    
}

-(void)ys_setoffTapAction{
    
    
}


@end
