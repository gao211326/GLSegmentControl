//
//  MySegmentedControl.h
//  RightMenuTest
//
//  Created by 高磊 on 15/7/13.
//  Copyright (c) 2015年 高. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MySegmentedControl;
@protocol MySegmentedControlDelegate <NSObject>

- (void)segmentedControlSelectIndex:(NSInteger )index;

@end

@interface MySegmentedControl : UIView

- (id)initWithSectionTitles:(NSArray *)titleArray;

@property (nonatomic,strong)NSArray *sectionTitles;

@property (nonatomic,weak)id <MySegmentedControlDelegate>delegate;

@end
