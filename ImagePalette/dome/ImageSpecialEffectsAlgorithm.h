//
//  ImageSpecialEffectsAlgorithm.h
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ImageSpecialEffectsAlgorithm : NSObject
+(unsigned char *)convertUIImageToData:(UIImage *)image;
+(UIImage *)convertDataToUIImage:(unsigned char*)imageData image:(UIImage *)imageSource;
+(unsigned char *)imageGrayWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height;
+(unsigned char *)imageReColorWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height;
+(unsigned char *)imageHightLightWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
