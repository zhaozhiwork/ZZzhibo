//
//  HomeViewController.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//


#import "HomeViewController.h"
#import "ZZPageView.h"
#import "ZZTitleStyle.h"
#import "AnchorViewController.h"

@interface HomeViewController ()
@property(nonatomic , strong)NSMutableArray <UIViewController *>*childVcs;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setupNavigationBar];
    [self setupPageView];
}
-(NSMutableArray<UIViewController *> *)childVcs{
    if (!_childVcs) {
        _childVcs = [NSMutableArray array];
    }
    return _childVcs;
}
#pragma mark --- 设置pageView的样式 --
-(void)setupPageView{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"types.plist" ofType:nil];
    NSArray *chanelArray = [NSArray arrayWithContentsOfFile:path];
   // NSArray *titles = @[@"游戏", @"娱乐娱乐娱乐",@"趣玩", @"美女女", @"颜值颜值", @"趣玩", @"美女女", @"颜值颜值"];
    ZZTitleStyle *style = [ZZTitleStyle titleStyle];
    [style setChanelHeight:44];
    
    for (NSInteger  i = 0; i<chanelArray.count; i++) {
        AnchorViewController *childVc = [[AnchorViewController alloc]init];
        childVc.homeType = [chanelArray[i] valueForKey:@"type"];
        [self.childVcs addObject:childVc];
    }
    ZZPageView *pageView = [[ZZPageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titles:chanelArray childVcs:self.childVcs parentVc:self titleStyle:style];
    [self.view addSubview:pageView];
}
#pragma mark -- 导航栏的样式
-(void)setupNavigationBar{
    UIImage *leftImage = [UIImage imageNamed:@"home-logo"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIImage *rightImage = [UIImage imageNamed:@"search_btn_follow"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(collectionButtonClick)];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 32)];
    searchBar.placeholder = @"主播昵称/房间号/链接";
    [searchBar setSearchBarStyle:(UISearchBarStyleMinimal)];
   UITextField *textFiled =  [searchBar valueForKey:@"_searchField"];
    textFiled.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark -- 收藏按钮的点击事件 -- 
-(void)collectionButtonClick{
    NSLog(@"点击了收藏按钮");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
