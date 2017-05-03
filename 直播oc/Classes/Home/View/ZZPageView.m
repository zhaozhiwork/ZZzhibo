//
//  ZZPageView.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//


#import "ZZPageView.h"
#import "ZZTitleView.h"
#import "ZZContentView.h"
#import "ZZTitleStyle.h"


@interface ZZPageView ()<ZZTitleViewDelegate,ZZContentViewDelegate>
@property(nonatomic, strong)NSArray <NSString *>*titles;
@property (nonatomic, strong)NSArray <UIViewController *>*childVcs;
@property (nonatomic, strong)UIViewController *parentVc;
@property (nonatomic, strong) ZZTitleView *titleView;
@property (nonatomic , strong)ZZContentView *contentView;
@property (nonatomic , strong)ZZTitleStyle *titleStyle;
@end

@implementation ZZPageView

/**初始化方法*/
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc titleStyle:(ZZTitleStyle *)titleStyle{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        self.titleStyle = titleStyle;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    self.titleView = [[ZZTitleView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.titleStyle.chanelHeight) titles:self.titles titleStyle:self.titleStyle];
     self.titleView.delegate = self;
    [self addSubview:self.titleView];
    
    self.contentView = [[ZZContentView alloc]initWithFrame:CGRectMake(0, self.titleStyle.chanelHeight, self.bounds.size.width, self.bounds.size.height - self.titleStyle.chanelHeight) childVcs:self.childVcs parentVc:self.parentVc];
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
    
}

-(void)clickTitleView:(ZZTitleView *)titleView atIndex:(NSInteger)index{
    [self.contentView setCurrentPageIndex:index];
}
-(void)contentView:(ZZContentView *)contentView atIndex:(NSInteger)index{
    [self.titleView setAdjustTitleLabel:index];
}
@end
