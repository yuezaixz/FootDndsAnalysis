//
//  FootPeripheal.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/9.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "FootPeripheal.h"

@implementation FootPeripheal

- (void)startReadData{
    if (self.notifyCharact) {
        [self.notifyCharact readValueWithBlock:^(NSData *data, NSError *error) {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(notifyPeripheralData:)]) {
                NSLog(@"1");
                //TODO 解析数据,拼装数据
                //调用delegate
            }
        }];
    }
}

- (void)writeCharactForByte:(int8_t)aByte{//比如 0xFF
    if (self.writeCharact) {
        [self.writeCharact writeByte:aByte completion:^(NSError *error) {
            
        }];
    }
}

- (void)writeCharactForStr:(NSString *)str{//比如 0xFF
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    if (self.writeCharact) {
        [self.writeCharact writeValue:data completion:^(NSError *error) {
            
        }];
    }
}

@end
