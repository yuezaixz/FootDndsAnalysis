//
//  FootBleDevTableViewCell.m
//  Foot
//
//  Created by 吴迪玮 on 15/7/16.
//  Copyright (c) 2015年 pandoranews. All rights reserved.
//

#import "FootBleDevTableViewCell.h"
#import "Colors.h"

    
@interface FootBleDevTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *bleSignalLabel;
@property (weak, nonatomic) IBOutlet UILabel *bleDeviceNameLabel;

@end

@implementation FootBleDevTableViewCell

- (void)awakeFromNib {
    
    self.bleConnectLabel.layer.cornerRadius = self.bounds.size.height / 2.0f;
    self.bleConnectLabel.layer.borderColor = FOOT_DARK_GRAY_151.CGColor;
    self.bleConnectLabel.layer.borderWidth = 1.0f;
    self.bleConnectLabel.layer.cornerRadius = self.bounds.size.height/4;
    
    self.bleConnectLabel.clipsToBounds = YES;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)connectBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(connectPeripheral:)]) {
        [self.bleConnectLabel setTitle:@"连接中" forState:UIControlStateNormal];
        [self.delegate performSelector:@selector(connectPeripheral:) withObject:self.peripheral];
    }
}

-(void)setPeripheral:(LGPeripheral *)peripheral{
    _peripheral = peripheral;
    self.bleSignalLabel.hidden = NO;
    self.bleSignalLabel.text =[NSString stringWithFormat:@"%d",(int)_peripheral.RSSI];
    self.bleDeviceNameLabel.text = _peripheral.name;
    [self.bleConnectLabel setTitle:@"连接" forState:UIControlStateNormal];
//    self.bleConnectLabel.layer.borderColor = FOOT_DARK_GRAY_151.CGColor;
//    [self.bleConnectLabel setTitleColor:FOOT_LIGHT_BLACK_74 forState:UIControlStateNormal];
}

@end
