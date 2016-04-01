//
//  WUGesturesUnlockIndicator.m
//  WUGesturesToUnlock
//
//  Created by wuqh on 16/4/1.
//  Copyright © 2016年 wuqh. All rights reserved.
//

#import "WUGesturesUnlockIndicator.h"

@interface WUGesturesUnlockIndicator()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation WUGesturesUnlockIndicator

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    //创建9个按钮
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_indicator_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_indicator_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    int cols = 3;//总列数
    
    CGFloat x = 0,y = 0,w = 9,h = 9;//bounds
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);//间距
    
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        
        col = i%cols;
        row = i/cols;
        
        x = margin + (w+margin)*col;
        y = margin + (w+margin)*row;
        
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons ;
}

#pragma mark - publick
- (void)setGesturesPassword:(NSString *)gesturesPassword {
    
    if (gesturesPassword.length == 0) {
        for (UIButton *button in self.buttons) {
            button.selected = NO;
        }
        return;
    }
    
    for (int i = 0; i < gesturesPassword.length; i++) {
        
        NSString *s = [gesturesPassword substringWithRange:NSMakeRange(i, 1)];
      
        [self.buttons[s.integerValue] setSelected:YES];
        
    }
}

@end
