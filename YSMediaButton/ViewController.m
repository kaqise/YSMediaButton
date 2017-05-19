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

@interface ViewController ()<YSMediaButtonDelegate>

@property (nonatomic, strong)UILabel *voiceLabel;

@property (nonatomic, strong)UILabel *brightnessLabel;

@property (nonatomic, strong)YSMediaButton *button;

@property (nonatomic, assign)CGPoint startPoint;

@property (nonatomic, assign)CGPoint endPoint;

@end

@implementation ViewController
{
    NSTimeInterval _currentTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [[YSMediaButton alloc]init];
    _button.touchDelegate = self;
    _button.backgroundColor = [UIColor redColor];
    [self.view addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
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



@end
