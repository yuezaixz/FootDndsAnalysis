//
//  FootService.h
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/11.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FootPeripheal.h"
#import "FootDataModel.h"

@interface FootService : NSObject<FootPeriphealDelegate>

@property (nonatomic,strong) FootPeripheal *footPeripheal;

+ (instancetype)sharedInstance;

- (void)startWithFootPeripheal:(FootPeripheal *)footPeripheal;

- (void)pause;

- (void)parseOnlineData:(FootDataModel *)frdata ;

- (void)end;

@end
