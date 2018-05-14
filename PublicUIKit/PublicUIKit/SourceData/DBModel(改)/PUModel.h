//
//  PUModel.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/14.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 所有继承于PUModel或PUModel子类的模型均能存进数据库
 */
@interface PUModel : NSObject<NSCoding,NSCopying>

@end
