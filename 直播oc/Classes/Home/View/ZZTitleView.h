//
//  ZZTitleView.h
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ZZTitleStyle,ZZTitleView;

@protocol  ZZTitleViewDelegate<NSObject>

-(void)clickTitleView:(ZZTitleView *)titleView atIndex:(NSInteger)index;

@end

@interface ZZTitleView : UIView

@property (nonatomic , weak)id<ZZTitleViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles titleStyle:(ZZTitleStyle *)titleStyle;

-(void)setAdjustTitleLabel:(NSInteger)targetIndex;
@end
