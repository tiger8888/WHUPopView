//
//  WHUPopViewManager.h
//  TEST_TAO_Animation
//
//  Created by SuperNova on 15/11/12.
//  Copyright (c) 2015年 SuperNova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WHUPopViewManager : NSObject
-(void)showWithView:(UIView*)view height:(CGFloat)height;
+(WHUPopViewManager*)manager;
@end
