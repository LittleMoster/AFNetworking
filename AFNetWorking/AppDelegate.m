//
//  AppDelegate.m
//  AFNetWorking
//
//  Created by cguo on 2017/8/25.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "AppDelegate.h"
#import "HttpTool.h"
#import "Header.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property(nonatomic,strong)NSString *DownLoadUrl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    [self CheakVersion];
    return YES;
}
-(void)CheakVersion
{
    //http://172.16.38.78:8888/UpdateRest/CheckNewVersion?versionName=1.0&osType=1&appKey=c27b01646460958c
    //    1.获取当前版本的版本号
    NSString *versionStr=  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //    float version=[versionStr floatValue];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"osType"]=@(2);
    dic[@"versionName"]=versionStr;
    dic[@"appKey"]=APPKEY;
    
    
    
    [HttpTool GET:UpdateAppUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject[@"Code"] intValue] ==200) {
            [self ToUpdateApp:responseObject[@"Data"]];
        }else
        {
           
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:responseObject[@"Message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
                
                [alert show];
                
            
            
        }
        //        if ([responseObject[@"code"] intValue] ==400) {
        //            if ([APPKEY isEqualToString:BQTestAPPKey]) {
        //
        //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有新版本更新" message:[responseObject[@"Message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
        //                alert.tag=2;
        //                [alert show];
        //            }
        //        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//有新版本更新时。弹出框提醒
-(void)ToUpdateApp:(NSDictionary*)AppInfo
{
    //下载链接
    self.DownLoadUrl=AppInfo[@"DownLoadUrl"];
    //更新内容
    NSString *UpdateInfo=AppInfo[@"UpdateInfo"];
    
    UpdateInfo=[UpdateInfo stringByReplacingOccurrencesOfString:@"@" withString:@"\n"];
    //是否强制更新
    
    //更新的版本号
    //    NSString *VersionName=AppInfo[@"VersionName"];
    
    int update =[AppInfo[@"ForcedUpdate"] intValue];
    if (update ==1) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有新版本更新" message:UpdateInfo delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
        alert.tag=2;
        [alert show];
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有新版本更新" message:UpdateInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        alert.tag=1;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            NSLog(@"取消了");
        }else
        {
            NSLog(@"跳转更新");
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:self.DownLoadUrl]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.DownLoadUrl]];
                
            }
            
        }
        
    }
    if (alertView.tag==2) {
        
        NSLog(@"更新");
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:self.DownLoadUrl]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.DownLoadUrl]];
            
        }
        
        
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
