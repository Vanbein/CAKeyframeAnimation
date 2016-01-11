//
//  ViewController.m
//  CAKeyframeAnimation
//
//  Created by 王斌 on 16/1/8.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "ViewController.h"


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ViewController (){
    NSInteger count;
}

@property(nonatomic, strong)UIView *view1;
@property(nonatomic, strong)UIView *view2;
@property(nonatomic, strong)UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //rect矩形运动的 view
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    self.view1.backgroundColor = [UIColor orangeColor];
//    self.view1.layer.bounds = CGRectMake(0, 0, 50, 50);
    self.view1.layer.cornerRadius = 8;
    self.view1.layer.position = CGPointMake(50, 50);
    self.view1.layer.anchorPoint = CGPointZero;
    [self.view addSubview:_view1];

    //round圆形运动的 view
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 30, 30)];
    self.view2.backgroundColor = [UIColor purpleColor];
    //    self.view2.layer.bounds = CGRectMake(0, 0, 30, 30);
    self.view2.layer.cornerRadius = 15;
    self.view2.layer.position = CGPointMake(150, 250);
    self.view2.layer.anchorPoint = CGPointZero;
    [self.view addSubview:_view2];

    //抖动动画 view
    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(50, 400, 50, 50)];
    self.view3.backgroundColor = [UIColor greenColor];
    //    self.view2.layer.bounds = CGRectMake(0, 0, 30, 30);
    self.view3.layer.cornerRadius = 10;
    self.view3.layer.position = CGPointMake(50, 400);
    self.view3.layer.anchorPoint = CGPointZero;
    [self.view addSubview:_view3];
    
    count = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Add Animations

- (CAKeyframeAnimation *)rectAnimation{
    
    //1. 创建核心动画
    CAKeyframeAnimation *rectAnimation = [CAKeyframeAnimation animation];
    
    //平移
    rectAnimation.keyPath = @"position";
    //2. 要执行什么动画
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(50, 120)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 120)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(250, 50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    rectAnimation.values = @[value1, value2, value3, value4, value5];
    //2.1 设置动画执行完毕后不删除动画
    rectAnimation.removedOnCompletion = NO;
    //2.2 设置保存动画的最新状态
    rectAnimation.fillMode = kCAFillModeForwards;
    //2.3 设置动画执行时间
    rectAnimation.duration = 2.0;
    //2.4 设置动画节奏
    rectAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    rectAnimation.keyTimes = @[@0.0, @0.1, @0.8, @0.9, @1.0];
    rectAnimation.repeatCount = MAXFLOAT;
    //2.5. 设置代理
    rectAnimation.delegate = self;
    
    return rectAnimation;
}

- (CAKeyframeAnimation *)roundAnimation{
   
    //1. 创建核心动画
    CAKeyframeAnimation *roundAnimation = [CAKeyframeAnimation animation];
    
    //平移
    roundAnimation.keyPath = @"position";
    //2. 要执行什么动画
    //2.1 创建一条路径path
    CGMutablePathRef path = CGPathCreateMutable();
    //2.2 设置一个圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(50, 200, 100, 100));
    roundAnimation.path=path;
    //2.3 有creat 就一定要release
    CGPathRelease(path);
    
    //3.1 设置动画执行完毕后不删除动画
    roundAnimation.removedOnCompletion = NO;
//    roundAnimation.autoreverses = NO;
    //3.2 设置保存动画的最新状态
    roundAnimation.fillMode = kCAFillModeForwards;
    //3.3 设置动画执行时间
    roundAnimation.duration = 3.0;
    roundAnimation.repeatCount = MAXFLOAT;
    //3.4 设置动画节奏
//    roundAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //    rectAnimation.keyTimes = @[@0.0, @0.1, @0.8, @0.9, @1.0];
    //3.5. 设置代理
    roundAnimation.delegate = self;
    
    return roundAnimation;
}

- (CAKeyframeAnimation *)shakeAnimation{
    
//    CATransform3D rotationTransform  = CATransform3DMakeRotation(-0.05, 1, 1, 1);
//    CATransform3D rotationTransform2  = CATransform3DMakeRotation(0.05, 1, 1, 1);
//    
    //1. 创建核心动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    shakeAnimation.keyPath = @"transform.rotation";//transform.rotation
    //设置动画时间
    shakeAnimation.duration = 0.2;
    //设置图标抖动弧度
    //把度数转换为弧度  度数/180*M_PI

//    shakeAnimation.values = @[[NSValue valueWithCATransform3D:rotationTransform], [NSValue valueWithCATransform3D:rotationTransform2], [NSValue valueWithCATransform3D:rotationTransform]];   //@[@-0.04, @0.04, @-0.04];
    shakeAnimation.values = @[@(-DEGREES_TO_RADIANS(4)),@(DEGREES_TO_RADIANS(4)),@(-DEGREES_TO_RADIANS(4))];
    //设置动画的重复次数(设置为最大值)
    shakeAnimation.repeatCount = MAXFLOAT;
    shakeAnimation.fillMode = kCAFillModeForwards;
    shakeAnimation.removedOnCompletion = NO;
    shakeAnimation.delegate = self;
    return shakeAnimation;
}

#pragma mark - Custom Method


#pragma mark - Animation Delegate

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始！");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束！");
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    count ++;
    if (count%2 == 1) {
        
        [self.view1.layer addAnimation:[self rectAnimation] forKey:@"rect"];
    
        [self.view2.layer addAnimation:[self roundAnimation] forKey:@"round"];

        [self.view3.layer addAnimation:[self shakeAnimation] forKey:@"shake"];
    } else {
        
        
        [self.view1.layer removeAnimationForKey:@"rect"];
        
        [self.view2.layer removeAnimationForKey:@"round"];
        
        [self.view3.layer removeAnimationForKey:@"shake"];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}















@end
