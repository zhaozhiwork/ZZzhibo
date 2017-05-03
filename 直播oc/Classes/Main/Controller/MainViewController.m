//
//  MainViewController.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
}

-(void)addChildVC{
    
    UIViewController *childVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateInitialViewController];
    
    [self addChildViewController:childVC];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
