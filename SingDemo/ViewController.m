//
//  ViewController.m
//  SingDemo
//
//  Created by Mr on 2017/8/2.
//  Copyright © 2017年 Mr. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NSString+encrypt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(69, 69, 60, 45);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    [task cancel];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)clickBtn
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSDictionary *param = @{@"isPre":@3,
                            @"regionId":@0,
                            @"propertyId":@0,
                            @"sortId":@0,
                            @"sellPointId":@0,
                            @"cityId":@112,
                            @"pageIndex":@1,
                            @"pageSize":@30};
    
    NSString *url = [NSString stringWithFormat:@"https://gateway.beta.apitops.com/broker-service-api/v1/building/buildingList"];
    
//    [manger.requestSerializer setValue:[self getSignatureUrl:url parmar:param] forHTTPHeaderField:@"Signature"];
    
    AFSecurityPolicy *secPolicy = [AFSecurityPolicy defaultPolicy];
    secPolicy.allowInvalidCertificates = YES;
    secPolicy.validatesDomainName = NO;
    manger.securityPolicy = secPolicy;
    
    NSURLSessionDataTask *task = [manger GET:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"-=-=-=-=-=-%@", uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"************%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"===============%@", error);
    }];
}

- (NSString *)getSignatureUrl:(NSString *)urlStr parmar:(NSDictionary *)par
{
    NSString *url = [urlStr stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    url = [urlStr stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    NSString *body;
    if ([par isKindOfClass:[NSDictionary class]]) {
        body = AFQueryStringFromParameters(par);
    }else
    {
        body = @"00000000000000000000000000000000";
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString *nowDate = [formatter stringFromDate:date];
    
    NSString *findSign = [NSString stringWithFormat:@"%@%@%@%@", [url lowercaseString], [body toMD5], nowDate, @"374fa3ab6b1fae595db5382afe415bce"];
    return [findSign toMD5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
