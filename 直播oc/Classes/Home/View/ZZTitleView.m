//
//  ZZTitleView.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import "ZZTitleView.h"
#import "ZZTitleStyle.h"

@interface ZZTitleView ()
@property(nonatomic, strong)NSArray <NSString *>*titles;
@property (nonatomic, strong)ZZTitleStyle *style;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic ,strong) NSMutableArray <UILabel *>*titleLabels;
@property (nonatomic , assign)NSInteger currentIndex;
 @end

@implementation ZZTitleView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles titleStyle:(ZZTitleStyle *)titleStyle{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = titleStyle;
        self.currentIndex = 0;
        [self setupUI];
        [self setupTitleLabelFrames];
    }
    return self;
}
-(NSMutableArray<UILabel *> *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(void)setupUI{
    [self addSubview:self.scrollView];
    for (NSInteger i = 0; i<self.titles.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = [self.titles[i] valueForKey:@"title"];
        titleLabel.font = [UIFont systemFontOfSize:self.style.fontSize];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = i == 0?self.style.selectColor:self.style.normalColor;
        titleLabel.tag = i;
        [self.scrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tap];
        [titleLabel setUserInteractionEnabled:YES];
    }
}
-(void)setupTitleLabelFrames{
    for (NSInteger i = 0; i<self.titleLabels.count; i++) {
        CGFloat W = 0;
        CGFloat H = self.bounds.size.height;
        CGFloat X = 0;
        CGFloat Y = 0;
        W = [[self.titles[i] valueForKey:@"title"] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.style.fontSize]} context:nil].size.width;
        if ( i == 0) {
            X = self.style.itemMargin*0.5;
        }else{
            UILabel *tmpLabel = self.titleLabels[i - 1];
            X = CGRectGetMaxX(tmpLabel.frame) + self.style.itemMargin;
        }
        self.titleLabels[i].frame  = CGRectMake(X, Y, W, H);
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX([self.titleLabels lastObject].frame) +self.style.itemMargin*0.5, self.style.chanelHeight);
}
#pragma mark --标题按钮的点击事件 -- 
-(void)titleLabelClick:(UITapGestureRecognizer *)sender{
    UILabel *selectLabel = (UILabel *)sender.view;
    UILabel *sourceLabel = self.titleLabels[self.currentIndex];
    selectLabel.textColor = self.style.selectColor;
    sourceLabel.textColor = self.style.normalColor;
    
    self.currentIndex = sender.view.tag;
    
    [self.delegate clickTitleView:self atIndex:self.currentIndex];
    
    [self adjustTitleViewFrameWith:sender.view];
}
-(void)setAdjustTitleLabel:(NSInteger)targetIndex{
    if (targetIndex == self.currentIndex) return;
    UILabel *targetLabel = self.titleLabels[targetIndex];
    UILabel *sourceLabel = self.titleLabels[self.currentIndex];
    
    /**切换文字颜色*/
    targetLabel.textColor = self.style.selectColor;
    sourceLabel.textColor = self.style.normalColor;
    
    self.currentIndex = targetIndex;
    
    [self adjustTitleViewFrameWith:targetLabel];
}

-(void)adjustTitleViewFrameWith:(UIView *)sender{
    /**调整位置*/
    CGFloat offsetX = sender.center.x - self.scrollView.bounds.size.width*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    if (offsetX>self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
        offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
@end
