//
//  ViewController.m
//  Accelerator
//
//  Created by song on 2018/4/23.
//  Copyright © 2018年 YiJie. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic,strong) CMMotionManager *mgr;
@property (nonatomic,strong) UIView *ball;
@property (nonatomic,assign) CGPoint velocity;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mgr = [[CMMotionManager alloc]init];
    
    if ([self.mgr isAccelerometerAvailable]) {
        [self.mgr startAccelerometerUpdates];
    }else{
        NSLog(@"加速器不可用");
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CMAcceleration acceleration = self.mgr.accelerometerData.acceleration;
    NSLog(@"%f %f %f", acceleration.x, acceleration.y, acceleration.z);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现相应的响应者方法
/** 开始摇一摇 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
}

/** 摇一摇结束（需要在这里处理结束后的代码） */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) return;
    
    NSLog(@"motionEnded");
}

/** 摇一摇取消（被中断，比如突然来电） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
}
@end
