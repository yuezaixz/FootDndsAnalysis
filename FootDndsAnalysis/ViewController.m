//
//  ViewController.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/7.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "ViewController.h"
#import "LGBluetooth.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dynamicBtn;
@property (weak, nonatomic) IBOutlet UIButton *staticBtn;

@end

@implementation ViewController{
    DeviceSelectTabbarMenu *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    menu = [[DeviceSelectTabbarMenu alloc] initWithTabbarHeight:40.0];
    menu.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionDynamicTest:(id)sender {
    FootPeripheal *footPeripheal = [BleService sharedInstance].footPeripheal;
    if (footPeripheal && footPeripheal.writeCharact && footPeripheal.notifyCharact) {
        [footPeripheal writeToStartFootData];
        [footPeripheal startReadData];
    }
}

- (IBAction)actionStaticTest:(id)sender {
    FootPeripheal *footPeripheal = [BleService sharedInstance].footPeripheal;
    if (footPeripheal && footPeripheal.writeCharact && footPeripheal.notifyCharact) {
        [footPeripheal writeToStopFootData];
        [footPeripheal stopReadData];
    }
    
}

- (void)afterCloseAction{
    [BleService sharedInstance].delegate = self;
    [self refreshHomeBtn];
}

- (void)successConnectPeripheral:(FootPeripheal *)footPeripheral{
    NSLog(@"成功连接");
}
- (void)successFindWriteCharct:(LGCharacteristic *)writeCharct{
    [self refreshHomeBtn];
    NSLog(@"成功找到写特征");
}
- (void)successFindReadCharct:(LGCharacteristic *)readCharct{
    [self refreshHomeBtn];
    NSLog(@"成功找到读特征");
}

- (void)refreshHomeBtn{
    if ([[BleService sharedInstance].footPeripheal isValid]) {
        [self.dynamicBtn setBackgroundColor:FOOT_GREEN_COLOR];
        [self.staticBtn setBackgroundColor:FOOT_ORANGE_COLOR];
    } else {
        [self.dynamicBtn setBackgroundColor:FOOT_DARK_GRAY_155];
        [self.staticBtn setBackgroundColor:FOOT_DARK_GRAY_155];
    }
}

@end
