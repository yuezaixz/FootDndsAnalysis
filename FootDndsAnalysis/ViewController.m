//
//  ViewController.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/7.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "ViewController.h"
#import "TabbarMenu.h"

@interface ViewController ()

@end

@implementation ViewController{
    TabbarMenu *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    menu = [[TabbarMenu alloc] initWithTabbarHeight:40.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionDynamicTest:(id)sender {

}

- (IBAction)actionStaticTest:(id)sender {
    
}


@end
