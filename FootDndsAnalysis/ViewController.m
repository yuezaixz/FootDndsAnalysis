//
//  ViewController.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/7.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "ViewController.h"
#import "DeviceSelectTabbarMenu.h"
#import "LGBluetooth.h"
#import "BleService.h"

@interface ViewController ()

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
    
}


@end
