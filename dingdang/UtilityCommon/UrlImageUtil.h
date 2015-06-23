//
//  UrlImageUtil.h
//  iNews
//
//  Created by xiao wen on 13-12-24.
//  Copyright (c) 2013年 xiao wen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loadImageFinish)(UIImage * image);

@interface UrlImageUtil : NSObject

+ (void)setImageWithURL:(NSString*)url
                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;
+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage;
+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage failImage:(UIImage*)failImage;
+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage failImage:(UIImage*)failImage finish:(loadImageFinish)finishImage;

+ (NSString *)image2String:(UIImage *)image compressionQuality:(CGFloat) compressionQuality;
+ (UIImage *)string2Image:(NSString *)string;
+ (UIImage *)imageByScalingProportionallyToSize:(UIImage*)sourceImage targetSize:(CGSize)targetSize;

+ (void)setButtonStatusImage:(UIButton*) btn normal:(NSString*)normal selected:(NSString*)selected;
+ (void)setButtonStatusBackgroundImage:(UIButton*) btn normal:(NSString*)normal selected:(NSString*)selected;

+ (UIImage*)rotateImage:(UIImage*)image orientation:(UIImageOrientation) orientation;

@end
