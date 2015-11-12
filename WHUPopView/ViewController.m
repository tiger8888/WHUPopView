//
//  ViewController.m
//  WHUPopView
//
//  Created by SuperNova on 15/11/12.
//  Copyright (c) 2015年 SuperNova. All rights reserved.
//

#import "ViewController.h"
#import "WHUPopViewManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)btnAction:(id)sender {
    UIImageView* imgview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Professortocat_v2"]];
    imgview.backgroundColor=[UIColor blueColor];
    [[WHUPopViewManager manager] showWithView:imgview height:250];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
