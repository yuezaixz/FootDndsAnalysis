//
//  TabbarMenu.h
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/9.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarMenu : UIView

@property (nonatomic) CGFloat diff;

-(instancetype)initWithTabbarHeight:(CGFloat)tabbarHeight;
- (void)triggerAction;

@end
