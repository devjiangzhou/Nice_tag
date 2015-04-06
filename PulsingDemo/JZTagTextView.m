//
//  TGTagTextView.m
//  PulsingDemo
//
//  Created by BaiJiangzhou on 15/3/26.
//  Copyright (c) 2015年 jiangzhou. All rights reserved.
//

#import "JZTagTextView.h"



CGFloat BoDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat BoRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@interface JZTagTextView ()
@property (nonatomic,assign) CGSize contentSize;
@end

@implementation JZTagTextView

-(void)setText:(NSString *)text{
    _text = text;
    
    if (self.text.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes =  @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : paragraphStyle};
        
        self.contentSize = [self.text boundingRectWithSize:CGSizeMake(200, HEIGHT)
                                              options:(NSStringDrawingUsesLineFragmentOrigin |
                                                       NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil].size;
    }
    CGFloat textWidth = self.contentSize.width + HEIGHT / 2 + 12;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, textWidth, HEIGHT);

    [self setNeedsDisplay];
}


-(void)setReverse:(BOOL)reverse{
    _reverse = reverse;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    if (_reverse) { //箭头朝右
        CGFloat textWidth = self.frame.size.width  ;
        
        [path addArcWithCenter:CGPointMake(textWidth - HEIGHT/2 - 2.5  , 8 ) radius:8 startAngle:BoDegreesToRadians(-90) endAngle:BoDegreesToRadians(-45) clockwise:YES];
        
        
        [path addArcWithCenter:CGPointMake(textWidth - 6 , HEIGHT/2) radius:4 startAngle:BoDegreesToRadians(-45) endAngle:BoDegreesToRadians(-45 + 90) clockwise:YES];

       [path addArcWithCenter:CGPointMake(textWidth - HEIGHT/2 - 2.5  , HEIGHT -  8 ) radius:8 startAngle:BoDegreesToRadians(45) endAngle:BoDegreesToRadians(45+45) clockwise:YES];
       
       [path  addLineToPoint:CGPointMake(5, HEIGHT)];
        
        [path addArcWithCenter:CGPointMake(5,  HEIGHT - 5) radius:5 startAngle:BoDegreesToRadians(90) endAngle:BoDegreesToRadians(180) clockwise:YES];
        
        [path addArcWithCenter:CGPointMake(5,   5) radius:5 startAngle:BoDegreesToRadians(180) endAngle:BoDegreesToRadians(180+90) clockwise:YES];
        
    }else{//操作
        CGFloat textWidth = self.frame.size.width - 6;

        [path addArcWithCenter:CGPointMake(textWidth, 5) radius:5 startAngle:BoDegreesToRadians(-90) endAngle:BoDegreesToRadians(0) clockwise:YES];
        
        
        [path addArcWithCenter:CGPointMake(textWidth, HEIGHT- 5 ) radius:5 startAngle:BoDegreesToRadians(0) endAngle:BoDegreesToRadians(90) clockwise:YES];
        
        [path addArcWithCenter:CGPointMake(HEIGHT/2 + 1.5, HEIGHT - 8 ) radius:8 startAngle:BoDegreesToRadians(90) endAngle:BoDegreesToRadians(90+45) clockwise:YES];
        
        
        [path addArcWithCenter:CGPointMake(5, HEIGHT/2) radius:4 startAngle:BoDegreesToRadians(135) endAngle:BoDegreesToRadians(135 + 90) clockwise:YES];
        
        
        [path addArcWithCenter:CGPointMake(HEIGHT/2 + 1.5,  8 ) radius:8 startAngle:BoDegreesToRadians(225) endAngle:BoDegreesToRadians(225+45) clockwise:YES];
    }
    
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] setFill];
    [path fill];

    
    if (self.text.length > 0) {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        shadow.shadowBlurRadius = 0;
        shadow.shadowOffset = CGSizeMake(0.0, 1.0);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        
        NSDictionary *attributes = @{
                                     NSShadowAttributeName : shadow,
                                     NSForegroundColorAttributeName : [UIColor colorWithRed:255 green:255 blue:255 alpha:1],
                                     NSFontAttributeName : [UIFont systemFontOfSize:14],
                                     NSParagraphStyleAttributeName : paragraphStyle,
                                     };
        
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:self.text
                                               attributes:attributes];
        if (_reverse) {
            [attributedText drawInRect:CGRectMake( 6 , (HEIGHT - self.contentSize.height )/2, self.contentSize.width, self.contentSize.height)];
        }else{
            [attributedText drawInRect:CGRectMake(HEIGHT / 2+ 6, (HEIGHT - self.contentSize.height )/2, self.contentSize.width, self.contentSize.height)];
        }
    }
    
}

@end
