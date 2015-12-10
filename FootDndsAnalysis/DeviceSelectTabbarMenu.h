//
//  TabbarMenu.h
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/9.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BleService.h"
#import "FootBleDevTableViewCell.h"
#import "LGBluetooth.h"

@protocol DeviceSelectTabbarMenuDelegate <NSObject>

@optional
- (void)beforOpenAction;
- (void)afterOpenAction;
- (void)beforeCloseAction;
- (void)afterCloseAction;

@end

@interface DeviceSelectTabbarMenu : UIView<UITableViewDelegate,UITableViewDataSource,BleDelegate,FootBleDevTableViewCellDelegate>

@property (nonatomic) CGFloat diff;
@property (nonatomic,strong) NSArray *peripherals;
@property (weak,nonatomic) id<DeviceSelectTabbarMenuDelegate> delegate;

-(instancetype)initWithTabbarHeight:(CGFloat)tabbarHeight;
- (void)triggerAction;

@end
