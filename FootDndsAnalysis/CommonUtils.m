//
//  CommonUtils.m
//  FootDndsAnalysis
//
//  Created by 吴迪玮 on 15/12/11.
//  Copyright © 2015年 Paodong. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (NSString *)stringNotNull:(id)t {
    NSString *rlt = @"";
    if (nil != t
        && ![t isEqual:[NSNull null]]
        && ![t isKindOfClass:[NSNull class]]
        && [t isKindOfClass:[NSString class]])
        rlt = t;
    
    return rlt;
}

+ (NSNumber *)numberNotNull:(id)t {
    NSNumber *rlt = @0;
    if (nil != t
        && ![t isEqual:[NSNull null]]
        && ![t isKindOfClass:[NSNull class]])
        rlt = @([t  integerValue]);
    return rlt;
}

+ (id)objectNotNil:(id)object{
    return object?object:[NSNull null];
}

@end
