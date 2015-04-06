//
//  TGTagView.h
//  PulsingDemo
//
//  Created by BaiJiangzhou on 15/3/26.
//  Copyright (c) 2015年 jiangzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kTagNomal,
    kTagLocation,
    kTagPeople,
} TagType;


@interface JZTagView : UIView

@property (nonatomic,assign) TagType tagtype;
@property (nonatomic,assign) CGPoint  iconPoint; //icon中心点
@property (nonatomic,assign) BOOL isEdit;  //是否可以编辑
@property (nonatomic,strong) NSString *text; //显示文字

@end
