//
//  PulsingView.m
//  PulsingDemo
//
//  Created by BaiJiangzhou on 15/3/25.
//  Copyright (c) 2015年 jiangzhou. All rights reserved.
//

#import "JZPulsingView.h"


@interface JZPulsingView ()
@property (nonatomic,strong) CALayer *imageLayer;
@property (nonatomic,strong) CALayer *pulsingLayer;
@property (nonatomic,strong) CALayer *pulsingLayer1;

@property (nonatomic,strong) CAAnimationGroup *iconGroup;
@property (nonatomic,strong) CAAnimationGroup *pulsingGroup;
@property (nonatomic,strong) CAAnimationGroup *pulsingGroup1;
@end

@implementation JZPulsingView

-(void)setIcon:(UIImage *)icon{
    _icon = icon;
    [self setup];
}


-(void)setup{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.8;
    animation.duration = 0.2;

    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = @0.8;
    animation1.toValue = @1.2;
    animation1.duration = 0.4;
    animation1.beginTime = animation.duration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = @1.2;
    animation2.toValue = @1;
    animation2.duration = 0.2;
    animation2.beginTime = animation.duration + animation1.duration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animation.duration + animation1.duration + animation2.duration + 0.1;
    animationGroup.repeatCount = 0;
    animationGroup.delegate = self;
    animationGroup.animations = @[animation,animation1,animation2];
    [animationGroup setValue:@"icon" forKey:@"animationName"];
    self.iconGroup = animationGroup;

    self.pulsingLayer = [self addPulsingLayer];
    [self.layer addSublayer:self.pulsingLayer];
    
    self.pulsingLayer1 = [self addPulsingLayer];
    [self.layer addSublayer: self.pulsingLayer1];
    
    self.pulsingGroup = [self addPulsingAnimationGroup:1];
    [self.pulsingGroup setValue:@"pulse" forKey:@"animationName"];

    self.pulsingGroup1 = [self addPulsingAnimationGroup:0.8];
    [self.pulsingGroup1 setValue:@"pulse1" forKey:@"animationName"];

    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(  (self.frame.size.width - self.icon.size.width) / 2, (self.frame.size.height - self.icon.size.height) / 2, self.icon.size.width , self.icon.size.height);
    imageLayer.contents = (__bridge id)(self.icon.CGImage);
    [self.layer addSublayer:imageLayer];
    self.imageLayer = imageLayer;
    
    [imageLayer addAnimation:animationGroup forKey:@"icon"];
}

- (void)animationDidStart:(CAAnimation *)animation{
    NSString *animationName = [animation valueForKey:@"animationName"];
    if ([animationName  isEqualToString:@"pulse"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * self.pulsingGroup.duration  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pulsingLayer1 addAnimation:self.pulsingGroup1 forKey:@"pulse1"];
        });
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
    if (finished) {
        NSString *animationName = [animation valueForKey:@"animationName"];

        if ([animationName isEqualToString:@"icon"]) {
            [self.imageLayer removeAnimationForKey:@"icon"];
            [self.pulsingLayer addAnimation:self.pulsingGroup forKey:@"pulse"];
        }else if ([animationName isEqualToString:@"pulse"]){
            [self.pulsingLayer removeAnimationForKey:@"pulse"];
        }else if ([animationName isEqualToString:@"pulse1"]){
            [self.pulsingLayer1 removeAnimationForKey:@"pulse1"];
            [self.imageLayer addAnimation:self.iconGroup forKey:@"icon"];
        }
    }
}

-(CALayer *)addPulsingLayer{
    CALayer *pulsingLayer = [CALayer layer];
    pulsingLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    pulsingLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    pulsingLayer.contentsScale = [UIScreen mainScreen].scale;
    pulsingLayer.backgroundColor = [UIColor blackColor].CGColor;
    pulsingLayer.cornerRadius = self.frame.size.width/2;
    pulsingLayer.opacity = 0;
    return pulsingLayer;
}

-(CAAnimationGroup *)addPulsingAnimationGroup:(CFTimeInterval)duration{
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    animation3.fromValue = @0.0;
    animation3.toValue = @1.0;
    animation3.duration = duration;
    
    CAKeyframeAnimation *animation4 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation4.duration =duration ;
    animation4.values = @[@0.8, @0.45, @0];
    animation4.keyTimes = @[@0, @0.2, @1];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration =  duration;
    animationGroup.repeatCount = 0;
    animationGroup.delegate = self;
    animationGroup.animations = @[animation3,animation4];
    
    return animationGroup;
}


@end
