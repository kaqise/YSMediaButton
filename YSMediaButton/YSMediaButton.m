//
//  YSMediaButton.m
//  Demo_02
//
//  Created by fdiostwo on 2017/5/19.
//  Copyright © 2017年 YueShi. All rights reserved.
//

#import "YSMediaButton.h"
#import <MediaPlayer/MediaPlayer.h>

/** 一格音量 */
#define kDefaultMinMovieSpace 30.0f

@interface YSMediaButton ()

@property (nonatomic, strong)UISlider *volumeSlider;

@property (nonatomic, strong)MPVolumeView *volumeView;

@end
@implementation YSMediaButton
{
    CGPoint _statrPoint;//开始的点
    CGPoint _endPoint;//结束的点
    CGFloat _startVolume;//开始的声音
    CGFloat _startBrightness;//开始的亮度
    NSTimeInterval _currentTime;//当前播放时间
    NSTimeInterval _totalTime;//视频总时间
    NSTimeInterval _ratio;//手移动是播放的比率
    Direction _direction;//方向
    TouchStyle _style;//修改的类型
    
}
//触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //获取触摸开始的坐标
    UITouch *touch = [touches anyObject];
    
    _statrPoint = [touch locationInView:self];
    
    if (_statrPoint.x <= self.bounds.size.width * 0.5) {//屏幕左侧调整亮度
        
        _startBrightness = [UIScreen mainScreen].brightness;
       
        _style = TouchStyle_Brightness;
        
    }else{//屏幕右侧调整音量
        
        _startVolume = self.volumeSlider.value;
        
        _style = TouchStyle_Volume;
        
    }
    _direction = Direction_None;//方向为空
    
    _currentTime = [self.touchDelegate ys_getPlayerCurrentTime];//记录当前播放时间
    
    _totalTime = [self.touchDelegate ys_getTotalTime];
    
    _ratio = _totalTime / 2 / self.bounds.size.width;//屏幕的1像素对应视频的要播多少秒(一个屏幕播总视频的一半)
    
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (_direction == Direction_LeftOrRight) {
        
        if ([self.touchDelegate respondsToSelector:@selector(ys_touchesEndMoveActionCurrentTime:)]) {
            [self.touchDelegate ys_touchesEndMoveActionCurrentTime:_currentTime];
        }
    }
    _startBrightness = [UIScreen mainScreen].brightness;
}

//移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    //获取移动后的点
    
    CGPoint panPoint = CGPointMake(currentP.x - _statrPoint.x, currentP.y - _statrPoint.y);
    
    if (_direction == Direction_None) {
        //移动方向
        if (panPoint.x >= kDefaultMinMovieSpace || panPoint.x <= -kDefaultMinMovieSpace) {//手指有移动方向为左右
            _direction = Direction_LeftOrRight;
        }else if (panPoint.y >= kDefaultMinMovieSpace || panPoint.y <= -kDefaultMinMovieSpace){//手指有移动方向为上下
            _direction = Direction_UpOrDown;
        }
    }
    
    if (_direction == Direction_None) {//无滑动
        return;
    }else if (_direction == Direction_UpOrDown){//上下滑动
        
        if (_style == TouchStyle_Brightness) {//修改亮度
            
            if (panPoint.y <= -30) {//向上滑增加亮度
                
                [[UIScreen mainScreen] setBrightness:_startBrightness + (- panPoint.y / kDefaultMinMovieSpace / 10)];
                
            }else if(panPoint.y > 30){//向下滑减小亮度
                
                [[UIScreen mainScreen] setBrightness:_startBrightness - (panPoint.y / kDefaultMinMovieSpace / 10)];
            }
            
        }else if (_style == TouchStyle_Volume){//修改音量
            
            if (panPoint.y < 0) {//向上滑增加音量
                
                [self.volumeSlider setValue:_startVolume + ( -panPoint.y / kDefaultMinMovieSpace / 10) animated:YES];
                
            }else{//向下滑减小音量
                
                [self.volumeSlider setValue:_startVolume - ( panPoint.y / kDefaultMinMovieSpace / 10) animated:YES];
                
            }
        }
    }else if (_direction == Direction_LeftOrRight){//左右滑动
        
        NSTimeInterval result;
        if (panPoint.x < 0) {//向左一后退
            result = _currentTime - (-panPoint.x * _ratio);
            result = result <= 0 ? 0 : result;
        }else{//向右移快进
            result = _currentTime + (panPoint.x * _ratio);
            result = result >= _totalTime ? _totalTime : result;
        }
        
        _currentTime = result;
        _statrPoint = currentP;
        
        if ([self.touchDelegate respondsToSelector:@selector(ys_touchesMovingActionCurrentTime:)]) {
            [self.touchDelegate ys_touchesMovingActionCurrentTime:_currentTime];
        }
    }
}

#pragma mark --- 懒加载
- (MPVolumeView *)volumeView{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc]init];
        [_volumeView sizeToFit];
    }
    return _volumeView;
}
- (UISlider *)volumeSlider{
    if (!_volumeSlider) {
        for (UIView *view in [self.volumeView subviews]) {
            if ([view.class.description isEqualToString:@"MPVolumeSlider"]) {
                _volumeSlider = (UISlider *)view;
            }
        }
    }
    return _volumeSlider;
}

@end
