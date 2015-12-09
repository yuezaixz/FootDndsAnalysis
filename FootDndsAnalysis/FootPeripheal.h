//
//  FootPeripheal.h
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/9.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBluetooth.h"

@protocol FootPeriphealDelegate <NSObject>

@optional
- (void)notifyPeripheralData:(NSDictionary *)data;

@end

@interface FootPeripheal : NSObject

@property (nonatomic,strong) LGPeripheral *peripheral;
@property (nonatomic,strong) LGService *service;
@property (nonatomic,strong) LGCharacteristic *notifyCharact;
@property (nonatomic,strong) LGCharacteristic *writeCharact;

@property (weak,nonatomic) id<FootPeriphealDelegate> delegate;

- (void)startReadData;
- (void)stopReadData;

- (void)writeToStartFootData;
- (void)writeCharactForByte:(int8_t)aByte;
- (void)writeCharactForStr:(NSString *)str;

@end
