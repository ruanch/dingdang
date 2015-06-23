//
//  UrlImageUtil.m
//  iNews
//
//  Created by xiao wen on 13-12-24.
//  Copyright (c) 2013年 xiao wen. All rights reserved.
//

#import "UrlImageUtil.h"
#import "UIImageView+AFNetworking.h"
#import "GlobalDefine.h"
//#import "NSURLRequest.h"

@implementation UrlImageUtil


+ (NSString *) image2String:(UIImage *)image compressionQuality:(CGFloat) compressionQuality{
    NSData *pictureData = UIImageJPEGRepresentation(image, compressionQuality);
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDir = [paths objectAtIndex:0];
//    NSString *dir = [cachesDir stringByAppendingPathComponent:@"zwd"];
//    NSFileManager *fileManager = [[NSFileManager alloc]init];
//    [fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
//    dir = [dir stringByAppendingPathComponent:@"zwd.jpg"];
//    DLog(dir);
//    [fileManager createFileAtPath:dir contents: pictureData attributes:nil];
    
    NSString *pictureDataString = nil;
    if (SystemVersionBelowSeven)
        pictureDataString = [pictureData base64Encoding];
    else
        pictureDataString = [pictureData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return pictureDataString;
}

+ (UIImage *)imageByScalingProportionallyToSize:(UIImage*)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
//    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if ((imageSize.width <= targetSize.width) && (imageSize.height <= targetSize.height))
        return sourceImage;
    //if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (scaledWidth > width) scaledWidth = width;
        if (scaledHeight > height) scaledHeight = height;
        
        // center the image
        
//        if (widthFactor < heightFactor) {
//            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
//        } else if (widthFactor > heightFactor) {
//            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
//        }
    }
    
    // this is actually the interesting part:
    CGSize realSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(realSize);
    
    CGRect thumbnailRect = CGRectZero;
    //thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

+ (UIImage *) string2Image:(NSString *)string {
    NSData *data = nil;
    if (SystemVersionBelowSeven)
        data = [[NSData alloc]initWithBase64Encoding:string];
    else
        data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+ (void)setImageWithURL:(NSString*)url
                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:nil];
    __weak UIImageView *weakImageView = imageView;
    //带本地缓存的
    [weakImageView setImageWithURLRequestLocalCache:url placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        if (success)
            success(request, response, image);
        //            weakImageView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        //weakImageView.image = failImage;
        if (failure)
            failure(request, response, error);
    }];
}

+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage
{
    [self setImageWithURL:imageview withUrl:url defaultImage:defaultImage failImage:defaultImage];
}

+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage failImage:(UIImage*)failImage
{
    if ((url != nil) && (url.length > 0))
    {
        __weak UIImageView *weakImageView = imageview;

        //带本地缓存的
        [weakImageView setImageWithURLRequestLocalCache:url placeholderImage:defaultImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            weakImageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            weakImageView.image = failImage;
        }];

        
//        [weakImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]] placeholderImage:defaultImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//            weakImageView.image = image;
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//            weakImageView.image = failImage;
//        }];


    }
    else
        imageview.image = failImage;
}

+ (void)setImageWithURL:(UIImageView*)imageview withUrl:(NSString*)url defaultImage:(UIImage*)defaultImage failImage:(UIImage*)failImage finish:(loadImageFinish)finishImage{

    if ((url != nil) && (url.length > 0))
    {
        __weak UIImageView *weakImageView = imageview;


        //带本地缓存的
        [weakImageView setImageWithURLRequestLocalCache:url placeholderImage:defaultImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            //            weakImageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            weakImageView.image = failImage;
        }];

//        [weakImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]] placeholderImage:defaultImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//            weakImageView.image = image;
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//            weakImageView.image = failImage;
//        }];

    }
    else
        imageview.image = failImage;

    if (finishImage) {
        finishImage(imageview.image);
    }

}

+ (void)setButtonStatusImage:(UIButton*) btn normal:(NSString*)normal selected:(NSString*)selected;
{
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
}

+ (void)setButtonStatusBackgroundImage:(UIButton*) btn normal:(NSString*)normal selected:(NSString*)selected
{
    [btn setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
}

+ (UIImage*)rotateImage:(UIImage*)image orientation:(UIImageOrientation) orientation
{
    
    long double rotate = 0.0;
    
    CGRect rect;
    
    float translateX = 0;
    
    float translateY = 0;
    
    float scaleX = 1.0;
    
    float scaleY = 1.0;
    
    
    
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate = M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = 0;
            
            translateY = -rect.size.width;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate = 3 * M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = -rect.size.height;
            
            translateY = 0;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate = M_PI;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = -rect.size.width;
            
            translateY = -rect.size.height;
            
            break;
            
        default:
            
            rotate = 0.0;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = 0;
            
            translateY = 0;
            
            break;
            
    }
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newPic;
    
}

@end
