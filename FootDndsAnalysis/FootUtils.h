//
//  FootUtils.h
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/11.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FootDataModel.h"

@interface FootUtils : NSObject

+ (int)countPoint1MaxForce:(int)iPress;
+ (int)countPoint2MaxForce:(int)iPress;
+ (int)countPoint3MaxForce:(int)iPress;

+ (BOOL)isAnyMoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isForeThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isPoint3MoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isAnyMoreThanMaxStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isEveryLessThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isPoint1LessThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isPoint2LessThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;
//是否全掌大于stand，前掌两个点至少一个并且后掌点大于返回YES
+ (BOOL)isWholeMoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

//是否前掌有点大于stand，前掌两个点至少一个大于返回YES
+ (BOOL)isForeAnyMoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

//是否前掌两个点都大于stand，前掌两个点都大于返回YES
+ (BOOL)isForeEveryMoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isPoint1MoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

+ (BOOL)isPoint2MoreThanStand:(FootDataModel *)frdata adjustData:(FootDataModel *)adjustData;

@end
