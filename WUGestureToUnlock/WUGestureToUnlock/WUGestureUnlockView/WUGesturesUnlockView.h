//
//  WUGesturesLockView.h
//  WUGesturesToUnlock
//
//  Created by wuqh on 16/4/1.
//  Copyright © 2016年 wuqh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WUGesturesUnlockView;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@protocol WUGesturesUnlockViewDelegate <NSObject>

- (void)gesturesUnlockView:(WUGesturesUnlockView *)unlockView drawRectFinished:(NSMutableString *)gesturePassword;

@end

@interface WUGesturesUnlockView : UIView

@property (nonatomic,weak) id<WUGesturesUnlockViewDelegate> delegate;

@end
