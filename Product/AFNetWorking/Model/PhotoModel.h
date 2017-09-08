//
//  PhotoModel.h
//  AFNetWorking
//
//  Created by cguo on 2017/8/25.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
/*
 上传图片的模型类，与httpTool上传图片的方法绑定，用第三方框架获取多张图片时，传入PHAssets类型的数组，内部进行处理图片，包括压缩、图片的名称、类型、data数据等
 */
@interface PhotoModel : NSObject


@property (nonatomic, strong) UIImage *image;
//对应网站上[upload.php中]处理文件的[字段"file"]
@property (nonatomic, strong) NSString *imageName;
//要保存在服务器上的[文件名]
@property (nonatomic, strong) NSString  *fileName;
//上传文件的[mimeType]（图片的类型）
@property (nonatomic, strong) NSString *mimeType;
//图片的data数据
@property (nonatomic, strong) NSData* imageData;
//图片的尺寸
@property(nonatomic,assign)CGSize imageSize;




//+(NSMutableArray*)GetPhotoModelArrByPHAssetArr:(NSArray*)PHAssets;

//获取图片，以及压缩图片，设置图片的尺寸CGSizeMake(0, 0)代表原图
+(NSMutableArray*)GetPhotoModelArrByPHAssetArr:(NSArray<PHAsset*>*)PHAssets imageSize:(CGSize)imagesize;
@end
