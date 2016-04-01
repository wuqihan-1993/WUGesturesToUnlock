//
//  WUGesturesLockView.m
//  WUGesturesToUnlock
//
//  Created by wuqh on 16/4/1.
//  Copyright © 2016年 wuqh. All rights reserved.
//

#import "WUGesturesUnlockView.h"



@interface WUGesturesUnlockView()

@property (nonatomic, strong) NSMutableArray *selectedBtns;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation WUGesturesUnlockView

//加载完xib的时候调用
- (void)awakeFromNib {
    [self setup];
}

//为什么要在这个方法中布局子控件，因为只调用这个方法，就表示父控件的尺寸确定
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    int cols = 3;//总列数
    
    CGFloat x = 0,y = 0,w = 0,h = 0;

    if (Screen_Width == 320) {
        w = 50;
        h = 50;
    }else {
        w = 58;
        h = 58;
    }    
    
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);//间距
    
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        
        col = i%cols;
        row = i/cols;
        
        x = margin + (w+margin)*col;

        y = margin + (w+margin)*row;
        if (Screen_Height == 480) {
            y = (w+margin)*row;
        }else {
            y = margin +(w+margin)*row;
        }
        
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

//只要调用这个方法就会把之前绘制的东西清空 重新绘制
- (void)drawRect:(CGRect)rect {
    if (self.selectedBtns.count == 0) return;
    // 把所有选中按钮中心点连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSUInteger count = self.selectedBtns.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.selectedBtns[i];
        if (i == 0) {
            //设置起点
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:_currentPoint ];
    
    [UIColorFromRGB(0xffc8ad) set];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 8;
    [path stroke];
}

#pragma mark - private
- (void)setup {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //创建9个按钮
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_selected"] forState:UIControlStateSelected];
        btn.tag = 1000+i;
        [self addSubview:btn];
    }
}

#pragma mark - action pan
- (void)pan:(UIPanGestureRecognizer *)pan {
    _currentPoint = [pan locationInView:self];
    
    [self setNeedsDisplay];
    
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, _currentPoint) && button.selected ==   NO) {
            
            button.selected = YES;
            [self.selectedBtns addObject:button];
            
        }
    }
    
    [self layoutIfNeeded];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        //保存输入密码
        NSMutableString *gesturePwd = @"".mutableCopy;
        for (UIButton *button in self.selectedBtns) {
            [gesturePwd appendFormat:@"%ld",button.tag-1000];
            button.selected = NO;
        }
        [self.selectedBtns removeAllObjects];
        
        //手势密码绘制完成后会掉
        if ([self.delegate respondsToSelector:@selector(gesturesUnlockView:drawRectFinished:)]) {
            [self.delegate gesturesUnlockView:self drawRectFinished:gesturePwd];
        }
        
    }
}

#pragma mark - getter
- (NSMutableArray *)selectedBtns {
    if (!_selectedBtns) {
        _selectedBtns = @[].mutableCopy;
    }
    return _selectedBtns;
}


@end
