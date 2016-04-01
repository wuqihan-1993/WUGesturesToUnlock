//
//  ViewController.m
//  WUGestureToUnlock
//
//  Created by wuqh on 16/4/1.
//  Copyright © 2016年 吴启晗. All rights reserved.
//

#import "ViewController.h"
#import "WUGesturesUnlockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)create:(id)sender {
    WUGesturesUnlockViewController *vc = [[WUGesturesUnlockViewController alloc] initWithUnlockType:WUUnlockTypeCreatePwd];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)validate:(id)sender {
    if ([WUGesturesUnlockViewController gesturesPassword].length > 0) {
        WUGesturesUnlockViewController *vc = [[WUGesturesUnlockViewController alloc] initWithUnlockType:WUUnlockTypeValidatePwd];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"还没有设置手势密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
    }
    
}
- (IBAction)delete:(id)sender {
    [WUGesturesUnlockViewController deleteGesturesPassword];
}


@end
