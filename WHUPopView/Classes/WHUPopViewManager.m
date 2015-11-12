//
//  WHUPopViewManager.m
//  TEST_TAO_Animation
//
//  Created by SuperNova on 15/11/12.
//  Copyright (c) 2015年 SuperNova. All rights reserved.
//

#import "WHUPopViewManager.h"
@interface WHUPopViewManager()
@property(nonatomic,strong) UIWindow* popWindow;
@property(nonatomic,strong) UIView* contentView;
@property(nonatomic,strong) UIView* mainview;
@property(nonatomic,strong) UIButton* backGroundButton;
@property(nonatomic,strong) NSLayoutConstraint* bottomGapCts;
@property(nonatomic,strong) NSLayoutConstraint* heightCts;
@property(nonatomic,assign) CATransform3D transform1;
@property(nonatomic,assign) CATransform3D transform2;
@property(nonatomic,assign) CATransform3D transform3;
@end
static WHUPopViewManager* shareInstance=nil;
@implementation WHUPopViewManager
+(WHUPopViewManager*)manager{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        shareInstance=[[WHUPopViewManager alloc] initWithPrivate];
    });
    return shareInstance;
}

-(id)initWithPrivate{
    self=[super init];
    if(self){
        CGRect rect=[UIScreen mainScreen].bounds;
        _popWindow=[[UIWindow alloc] initWithFrame:rect];
        _popWindow.hidden=YES;
        _popWindow.windowLevel=UIWindowLevelStatusBar;
        _backGroundButton=[[UIButton alloc] initWithFrame:rect];
        _backGroundButton.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0];
        [_backGroundButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _contentView=[[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints=NO;
        [_popWindow addSubview:_backGroundButton];
        [_popWindow addSubview:_contentView];
        NSDictionary* viewDic=@{@"conview":_contentView};
        [_popWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[conview]|" options:0 metrics:nil views:viewDic]];
        _heightCts=[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:1];
        _bottomGapCts=[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_popWindow attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [_popWindow addConstraint:_heightCts];
        [_popWindow addConstraint:_bottomGapCts];
    }
    return self;
}

-(id)init{
    return [[self class] manager];
}


-(void)showWithView:(UIView*)view height:(CGFloat)height{
    if(view==nil) return;
    _mainview=view;
    CGSize w=[UIScreen mainScreen].bounds.size;
    view.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary* viewDic=@{@"view":view};
    [_contentView addSubview:view];
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewDic]];
    [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewDic]];
    _heightCts.constant=height;
    _bottomGapCts.constant=height;
    [_popWindow setNeedsLayout];
    [_popWindow layoutIfNeeded];
    CGFloat wHeight = w.height;
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = -1 / 500.0;
    _transform1=transform1;
    
    CATransform3D transform2 = CATransform3DTranslate(transform1, 0, wHeight / 2, 0);
    transform2 = CATransform3DRotate(transform2, M_PI / 15, 1, 0, 0);
    transform2 = CATransform3DTranslate(transform2, 0, -wHeight / 2, 0);
    _transform2=transform2;
    
    CATransform3D  transform3 = CATransform3DTranslate(transform2, 0, -wHeight / 2-25, 0);
    transform3 = CATransform3DRotate(transform3, -M_PI / 15, 1, 0, 0);
    transform3 = CATransform3DTranslate(transform3, 0, wHeight / 2, 0);
    _transform3=transform3;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.values = @[[NSValue valueWithCATransform3D:transform1],[NSValue valueWithCATransform3D:transform2], [NSValue valueWithCATransform3D:transform3]];
    animation.keyTimes = @[ @0,  @(4 / 6.0), @1 ];
    animation.duration =0.5;
    animation.calculationMode=kCAAnimationCubic;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    UIWindow* keyWindow=[[UIApplication sharedApplication] keyWindow];
    keyWindow.layer.transform=transform3;
    [keyWindow.layer addAnimation:animation forKey:nil];
    _bottomGapCts.constant=0;
    _popWindow.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
        [_popWindow setNeedsLayout];
        [_popWindow layoutIfNeeded];
        _backGroundButton.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    }];
}

-(void)dismiss{
    if(_mainview==nil){
        return;
    }
    UIWindow* keyWindow=[[UIApplication sharedApplication] keyWindow];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.values = @[[NSValue valueWithCATransform3D:_transform3],[NSValue valueWithCATransform3D:_transform2], [NSValue valueWithCATransform3D:_transform1]];
    animation.keyTimes = @[ @0,  @(2 / 6.0), @1 ];
    animation.duration = 0.5;
    animation.calculationMode=kCAAnimationCubic;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyWindow.layer.transform=_transform1;
    [keyWindow.layer addAnimation:animation forKey:nil];
    _bottomGapCts.constant=_mainview.frame.size.height;
    [UIView animateWithDuration:0.6 animations:^{
        [_popWindow setNeedsLayout];
        [_popWindow layoutIfNeeded];
        _backGroundButton.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0];
    } completion:^(BOOL b){
        _popWindow.hidden=YES;
        [_mainview removeFromSuperview];
        _mainview=nil;
    }];
}
@end
