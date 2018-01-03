//
//  MySegmentedButton.m
//  RightMenuTest
//
//  Created by 高磊 on 15/7/13.
//  Copyright (c) 2015年 高. All rights reserved.
//

#define UICOLOR_FROM_RGB_OxFF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UICOLOR_FROM_RGB(r,g,b)             [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#import "MySegmentedButton.h"

@implementation MySegmentedButton


- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    
    if (self.titleNameLable.superview)
    {
        [self.titleNameLable removeFromSuperview];
        self.titleNameLable = nil;
    }
    
    self.titleNameLable = [[UILabel alloc]init];
    self.titleNameLable.font = [UIFont systemFontOfSize:15];
    self.titleNameLable.textColor = UICOLOR_FROM_RGB_OxFF(0xdddddd);
    [self addSubview:self.titleNameLable];

    self.titleNameLable.frame = CGRectMake(0,5,frame.size.width ,frame.size.height-5);

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [UICOLOR_FROM_RGB_OxFF(0xaaaaaa) set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapSquare;
    [path moveToPoint:CGPointMake(self.frame.size.width-2, 10)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-15, self.frame.size.height)];
    [path stroke];
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        self.titleNameLable.font = [UIFont systemFontOfSize:15];
        self.titleNameLable.textColor = UICOLOR_FROM_RGB_OxFF(0x222222);
        
    }
    else
    {
        self.titleNameLable.font = [UIFont systemFontOfSize:15];
        self.titleNameLable.textColor = UICOLOR_FROM_RGB_OxFF(0xaaaaaa);
    }
}
@end
