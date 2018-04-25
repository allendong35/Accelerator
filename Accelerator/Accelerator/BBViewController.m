//
//  BBViewController.m
//  Accelerator
//
//  Created by song on 2018/4/23.
//  Copyright © 2018年 YiJie. All rights reserved.
//

#import "BBViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface BBViewController ()

@property (nonatomic,strong) CMMotionManager *manager;
@end

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[CMMotionManager alloc]init];
    BBViewController * __weak weakSelf = self;
    if (self.manager.deviceMotionAvailable) {
        //加速器
        self.manager.deviceMotionUpdateInterval = 0.01f;
        [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion *data, NSError *error) {
                                         if (data.userAcceleration.x < -2.5f) {
                                             [weakSelf.navigationController popViewControllerAnimated:YES];
                                         }
                                     }];
    }
    
    //距离传感器
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        if (![CMPedometer isStepCountingAvailable]) {
            NSLog(@"---- ios8 计步器可用 ----");
            return;
        }
//
        CMPedometer *pedom = [[CMPedometer alloc] init];
//
        NSCalendar *caleddar = [NSCalendar currentCalendar];
//
        NSDateComponents *components = [caleddar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
//
        NSDate *startDate = [caleddar dateFromComponents:components];
        [pedom startPedometerUpdatesFromDate:startDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) { 
            if (!error) {
                if (pedometerData) {
                    NSLog(@"numberOfSteps = %@, distance = %@",pedometerData.numberOfSteps,pedometerData.distance);


                }
            }
        }];
    }
}

- (void)proximityStateDidChange:(NSNotification *)noti
{
    if ([UIDevice currentDevice].proximityState) {
        //有物体靠近
        NSLog(@"有物体靠近");
    } else {
        //物体离开
        NSLog(@"有物体离开");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
