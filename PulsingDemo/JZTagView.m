
//
//  TGTagView.m
//  PulsingDemo
//
//  Created by BaiJiangzhou on 15/3/26.
//  Copyright (c) 2015年 jiangzhou. All rights reserved.
//

#import "JZTagView.h"
#import "JZPulsingView.h"
#import "JZTagTextView.h"

@interface JZTagView ()
@property (nonatomic,strong) JZTagTextView *textView;
@property (nonatomic,strong) JZPulsingView *pulsingView;
@property (nonatomic,assign) BOOL reverse;

@end

@implementation JZTagView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.pulsingView = [[JZPulsingView alloc]initWithFrame:CGRectMake(0, 0, HEIGHT + 4, HEIGHT  + 4)];
        [self addSubview:self.pulsingView];
        self.tagtype = kTagNomal;
        self.pulsingView.backgroundColor = [UIColor clearColor];
        self.pulsingView.center = CGPointMake(self.pulsingView.center.x - 2, self.pulsingView.center.y - 2);
        
        self.textView = [[JZTagTextView alloc]initWithFrame:CGRectMake(HEIGHT - 4, 0, 100, HEIGHT)];
        self.textView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textView];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x,  self.textView.frame.size.width + HEIGHT - 4, self.frame.size.height);
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    self.backgroundColor  = [UIColor clearColor];
}

-(void)setIconPoint:(CGPoint)iconPoint{
    _iconPoint = iconPoint;
    self.frame = CGRectMake(iconPoint.x - HEIGHT / 2, iconPoint.y - HEIGHT / 2, self.frame.size.width, self.frame.size.height);
}

-(void)setTagtype:(TagType)tagtype{
    _tagtype = tagtype;
    switch (_tagtype) {
        case kTagNomal:
            self.pulsingView.icon = [UIImage imageNamed:@"big_biaoqian_dian"];
            break;
        case kTagLocation:
            self.pulsingView.icon = [UIImage imageNamed:@"big_biaoqian_didian"];
            break;
        case kTagPeople:
            self.pulsingView.icon = [UIImage imageNamed:@"big_biaoqian_ren"];
            break;
        default:
            break;
    }
}
-(void) setText:(NSString *)text{
    _text =text;
    [self.textView setText:text];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x,  self.textView.frame.size.width + HEIGHT - 4, self.frame.size.height);
}

@end
