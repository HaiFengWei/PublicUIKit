//
//  ViewController.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "ViewController.h"
#import "PUService.h"
#import "PUCommon.h"
#import "PUDownloadTool.h"
#import "TestModel.h"
#import "TestStudentModel.h"
@interface ViewController ()
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TestModel *testModel = [TestModel new];
    
    
    TestStudentModel *testStudentModel = [TestStudentModel new];
    testStudentModel.name = @"测试";
    
    testModel.age = 100;
    testModel.testModel = testStudentModel;
    [testModel saveOrUpdate];
    
    
//    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 200.f, 70.f, 20.f)];
//
//    [self.view addSubview:startButton];
//    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [startButton setTitle:@"开始下载" forState:UIControlStateNormal];
//    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//     UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(kPUScreenWidth - 90.f, 200.f, 70.f, 20.f)];
//    [stopButton addTarget:self action:@selector(stopButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [stopButton setTitle:@"停止下载" forState:UIControlStateNormal];
//    [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:stopButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([TestModel isExistInTable]) {
        NSArray *array = [TestModel findAll];
        if (array && array.count > 0)
        {
            TestModel *lastTestModel = [array lastObject];
            PULOG(@"name:%@",lastTestModel.testModel.name);
        }
    }
}

- (void)startButtonClick
{
//    PUService *service = [PUService new];
   _task = [[PUDownloadTool sharedTool] offLineDownLoadFileWithUrl:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg" progress:^(NSProgress * _Nullable progress) {
        PULOG(@"progress:%@",progress);
    } destination:^NSURL * _Nullable(NSURL *targetPath, NSURLResponse *response) {
        return targetPath;
    } success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        PULOG(@"filePath:%@",[fileUrlPath path]);
    } failure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    [_task resume];
////    if (_task == nil)
////    {
//        _task = [service offlineDownLoadWithURL:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg" progress:^(NSProgress * _Nullable progress) {
//            PULOG(@"progress:%@",progress);
//        } destination:^NSURL * _Nullable(NSURL *targetPath, NSURLResponse *response) {
//            return targetPath;
//        } downLoadSuccess:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath) {
//            PULOG(@"filePath:%@",[filePath path]);
//        } failure:^(NSError *error) {
//
//        }];
////    }
////    else
////    {
//        [_task resume];
////    }
}

- (void)stopButtonClick
{
    [_task suspend];
    _task = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
