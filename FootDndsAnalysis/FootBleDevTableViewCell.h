//
//  FootBleDevTableViewCell.h
//  Foot
//
//  Created by 吴迪玮 on 15/7/16.
//  Copyright (c) 2015年 pandoranews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBluetooth.h"

@protocol FootBleDevTableViewCellDelegate <NSObject>

- (void)connectPeripheral:(LGPeripheral *)peripheral;

@end

@interface FootBleDevTableViewCell : UITableViewCell

@property (nonatomic,strong) LGPeripheral *peripheral;
@property (nonatomic,weak) id<FootBleDevTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *bleConnectLabel;

@end
