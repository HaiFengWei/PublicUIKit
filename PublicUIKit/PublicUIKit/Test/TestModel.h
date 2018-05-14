//
//  TestModel.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/14.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "JKDBModel.h"
#import "TestStudentModel.h"
@interface TestModel : JKDBModel
@property (nonatomic, strong) TestStudentModel *testModel;

@property (nonatomic, assign) int age;
@end
