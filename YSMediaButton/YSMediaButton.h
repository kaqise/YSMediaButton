//
//  YSMediaButton.h
//  Demo_02
//
//  Created by fdiostwo on 2017/5/19.
//  Copyright © 2017年 YueShi. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  滑动方向
 */
typedef NS_ENUM(NSInteger , Direction) {
    Direction_LeftOrRight,
    Direction_UpOrDown,
    Direction_None,
};

/*
 * 修改类型
 */
typedef NS_ENUM(NSInteger , TouchStyle) {
    TouchStyle_Volume,//修改声音
    TouchStyle_Brightness,//修改亮度
    TouchStyle_None,
};


/*
 * 代理 
 */
@protocol YSMediaButtonDelegate <NSObject>

@required

- (NSTimeInterval)ys_getPlayerCurrentTime;//获取当前播放进度
- (NSTimeInterval)ys_getTotalTime;//获取视频的总时间
- (void)ys_touchesEndMoveActionCurrentTime:(NSTimeInterval)currentTime;//移动结束当前时间,用于修改player.currentTime;

@optional
- (void)ys_touchesMovingActionCurrentTime:(NSTimeInterval)currentTime;//移动中当前时间，用于修改UI
@end



@interface YSMediaButton : UIButton

@property (weak, nonatomic) id <YSMediaButtonDelegate> touchDelegate;

@end
