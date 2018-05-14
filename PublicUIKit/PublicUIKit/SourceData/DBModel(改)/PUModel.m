//
//  PUModel.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/14.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "PUModel.h"
#import "YYModel.h"
@implementation PUModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone{
    
    return [self yy_modelCopy];
}

@end
