//
//  ViewController.m
//  AFNetWorking
//
//  Created by cguo on 2017/8/25.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ViewController.h"
#import "TZImagePickerController.h"
#import "PhotoModel.h"
#import "HttpTool.h"

@interface ViewController ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)NSArray *photoModelArr;//上传图片模型数组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark --获取到图片之后会调用这个代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    //处理图片数组
    self.photoModelArr=[PhotoModel GetPhotoModelArrByPHAssetArr:assets imageSize:CGSizeMake(0, 0)];
    
 
    [HttpTool PostPhotoWithURL:@"" parameters:nil imageModels:self.photoModelArr progress:^(NSProgress *progress) {
        NSLog(@"%@",progress);
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"error-%@",error);
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:9 columnNumber:4 delegate:self];
    //    pickerController.allowCrop = YES;
    //    pickerController.needCircleCrop = YES;
    //    pickerController.circleCropRadius = 100;
    pickerController.naviBgColor=[UIColor whiteColor];
    pickerController.naviTitleColor=[UIColor blackColor];
    pickerController.barItemTextColor=[UIColor blackColor];
    pickerController.oKButtonTitleColorNormal=[UIColor greenColor];
    pickerController.oKButtonTitleColorDisabled=[UIColor blackColor];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
