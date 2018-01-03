//
//  MySegmentedControl.m
//  RightMenuTest
//
//  Created by 高磊 on 15/7/13.
//  Copyright (c) 2015年 高. All rights reserved.
//

#import "MySegmentedControl.h"
#import "NSString+Extension.h"
#import "MySegmentedButton.h"

static CGFloat const kLeftPadding = 5;
static CGFloat const kSpacePadding = 20;

@interface MySegmentedControl ()
{
    MySegmentedButton *         _selectButton;
}

@property (nonatomic,strong)UIScrollView *scrollView;

@end


@implementation MySegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)titleArray
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self commonInit];
        self.sectionTitles = titleArray;
        [self updateSegmentsRects];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)commonInit
{
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    [self addSubview:self.scrollView];
    
}

- (void)updateSegmentsRects
{
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    int i = 0;
    
    
    for (UIView *view in self.scrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)view;
            [button removeFromSuperview];
        }
    }
    
    MySegmentedButton *lastBUtton = nil;
    
    for (NSString *titleString in self.sectionTitles)
    {
        CGFloat stringWidth = 0;
        
        NSString *str = nil;
        
        if ([[[titleString substringToIndex:2] lowercaseString]isEqualToString:@"us"])
        {
            str = [titleString substringFromIndex:11];
        }
        else
        {
            str = titleString;
        }
        
        stringWidth = [str getDrawWidthWithFont:[UIFont systemFontOfSize:15]];
        
        MySegmentedButton *button = [MySegmentedButton buttonWithType:UIButtonTypeCustom];
        if (i == 0)
        {
            button.frame = CGRectMake(kLeftPadding,
                                      0,
                                      stringWidth + kSpacePadding,
                                      self.frame.size.height);
            button.selected = YES;
            _selectButton = button;
        }
        else
        {
            button.frame = CGRectMake(CGRectGetMaxX(lastBUtton.frame) + kLeftPadding,
                                      0,
                                      stringWidth + kSpacePadding,
                                      self.frame.size.height);
            
            button.selected = NO;
        }

        [button.titleNameLable setText:str];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        button.index = i;
        
        lastBUtton = button;
        i ++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastBUtton.frame), self.frame.size.height)];
}

- (void)setSectionTitles:(NSArray *)sectionTitles
{
    if (nil != sectionTitles && sectionTitles.count > 0)
    {
        _sectionTitles = sectionTitles;
        [self updateSegmentsRects];
    }
}

- (void)buttonClick:(MySegmentedButton *)button
{
    if (button.selected)
    {
        return;
    }
    _selectButton.selected = NO;
    button.selected = !button.selected;
    _selectButton = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControlSelectIndex:)])
    {
        [self.delegate segmentedControlSelectIndex:button.index];
    }
    
    [self scrollToSelectedSegmentIndex:button];
//    CGPoint point = CGPointMake(0, 0);
//    
//
//    
//    point.x = CGRectGetMinX(button.frame);
//    
//    if (point.x < self.frame.size.width / 2)
//    {
//        return;
//    }
//    
//    [self.scrollView setContentOffset:point animated:YES];
}


- (void)scrollToSelectedSegmentIndex:(MySegmentedButton *)button {
    CGRect rectForSelectedIndex = CGRectMake(CGRectGetMinX(button.frame),
                                             0,
                                             CGRectGetWidth(button.frame),
                                             self.frame.size.height);
    
    CGFloat selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (CGRectGetWidth(button.frame) / 2);
    CGRect rectToScrollTo = rectForSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset * 2;
    [self.scrollView scrollRectToVisible:rectToScrollTo animated:YES];
}
@end
