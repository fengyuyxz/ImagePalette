//
//  ImageSpecialEffectsAlgorithm.m
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "ImageSpecialEffectsAlgorithm.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation ImageSpecialEffectsAlgorithm
+(unsigned char *)convertUIImageToData:(UIImage *)image{
    //因为我们要把image 转换成一个个byte，所以使用指针的形势
    //1.需要将uiimage 转换成CGImage 因为CoreGraphsic处理的就是CGImage；2我们要创建颜色空间CGColorSpace进行处理分析；3.分配bit级别空间大小；
    //4.创建一个CGBitmap上下文；5渲染；
    //1
    CGImageRef imageRef=image.CGImage;
    CGSize imageSize=image.size;
    //2
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();//彩色图片使用rgb
    //3
    //每个像素点对应4个byte，因为每像素点是由R G B A组成。像素点个数 = 当前图片w * h
    //malloc:内存分配
    void *data = malloc(imageSize.width*imageSize.height*4);//整个图片占据的字节
    //4  1个字节8位
    //1 ：data 2\3 w h 4:bit
    CGContextRef context = CGBitmapContextCreate(data, imageSize.width, imageSize.height, 8, 4*imageSize.width, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, imageSize.width, imageSize.height), imageRef);
    //UIimage => Data
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return (unsigned char *)data;
}
+(UIImage *)convertDataToUIImage:(unsigned char*)imageData image:(UIImage *)imageSource {
    CGFloat width = imageSource.size.width;
    CGFloat height=imageSource.size.height;
    NSInteger dataLenght = width*height*4;
    //2 3 IMAGE INFO
    CGDataProviderRef provide = CGDataProviderCreateWithData(NULL, imageData, dataLenght, NULL);
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4*width;
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitMapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderIntent = kCGRenderingIntentDefault;
    //1 w 2 h 3 每个元素RGBA bit 4 每个像素位数bit 5每行字节  6 RGB 7 bitinfo 8 原始塑胶
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitMapInfo, provide, NULL, NO, renderIntent);
    UIImage *imageNew=[UIImage imageWithCGImage:imageRef];
     CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provide);
   
    return imageNew;
}

/// 灰度算法
/// @param imageData 原始图片转化成byte数据的指针
/// @param width 原始图片高
/// @param height 原始图片高
+(unsigned char *)imageGrayWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height{
    //1 分配内存空间 == image 的内存空间 = width * height *4
    unsigned char *resultData =malloc(width*height*sizeof(unsigned char)*4);//为什么用sizeof(unsigned char) 因为每一个小的单元都是一个unsigned char
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);//把resultData这个内存空间全部填充0；因为这款内存空间没有进行初始化，可能这块内存空间之前有其他在使用必须把它清理;
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h*width+w;//表示第几行第几个像素
            //像素RGBA = 4b
            unsigned char bitMapRed = *(imageData + imageIndex*4);//通过指针偏移获取
            unsigned char bitMapGreen = *(imageData + imageIndex*4+1);
            unsigned char bitMapBlue = *(imageData + imageIndex*4+2);
            
            int bitMap = bitMapRed*77/255  + bitMapGreen*151/255+bitMapBlue*88/255;//官方推荐算法
//            int bitMap = (bitMapRed + bitMapGreen + bitMapBlue)/3;
            unsigned char newBitMap=(bitMap>255)?255:bitMap;
            memset(resultData+imageIndex*4, newBitMap, 1);
            memset(resultData+imageIndex*4+1, newBitMap, 1);
            memset(resultData+imageIndex*4+2, newBitMap, 1);
        }
    }
    return resultData;;
}
+(unsigned char *)imageReColorWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height{
    //1 分配内存空间 == image 的内存空间 = width * height *4
    unsigned char *resultData =malloc(width*height*sizeof(unsigned char)*4);//为什么用sizeof(unsigned char) 因为每一个小的单元都是一个unsigned char
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);//把resultData这个内存空间全部填充0；因为这款内存空间没有进行初始化，可能这块内存空间之前有其他在使用必须把它清理;
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h*width+w;//表示第几行第几个像素
            //像素RGBA = 4b
            unsigned char bitMapRed = *(imageData + imageIndex*4);//通过指针偏移获取
            unsigned char bitMapGreen = *(imageData + imageIndex*4+1);
            unsigned char bitMapBlue = *(imageData + imageIndex*4+2);
            
            unsigned char bitMapRedNew = 255 - bitMapRed;
            unsigned char bitMapGreenNew = 255 - bitMapGreen;
            unsigned char bitMapBlueNew = 255 -bitMapBlue;
            
            memset(resultData+imageIndex*4, bitMapRedNew, 1);
            memset(resultData+imageIndex*4+1, bitMapGreenNew, 1);
            memset(resultData+imageIndex*4+2, bitMapBlueNew, 1);
        }
    }
    return resultData;;
}
+(unsigned char *)imageHightLightWithData:(unsigned char *)imageData width:(CGFloat)width height:(CGFloat)height {
    //1 分配内存空间 == image 的内存空间 = width * height *4
    unsigned char *resultData =malloc(width*height*sizeof(unsigned char)*4);//为什么用sizeof(unsigned char) 因为每一个小的单元都是一个unsigned char
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);//把resultData这个内存空间全部填充0；因为这款内存空间没有进行初始化，可能这块内存空间之前有其他在使用必须把它清理;
  //映射表方式有两种一中是将0-255的256个点都映射，一种是给出几个关键点使用插值算法；256除以32刚是8所以没过32点选一个关键点；
    NSArray *colorArrayBase=@[@"55",@"110",@"155",@"185",@"220",@"240",@"250",@"255"];
    NSMutableArray *colorArray =[@[] mutableCopy];
    //55 对应32 前面还有31个点；所以(55-0)/32就可以知道每两个点之间的插值；110对应64
    int beforNum=0;
    for (int i=0; i<8; i++) {
        NSString *numStr=[colorArrayBase objectAtIndex:i];
        int num=numStr.intValue;
        float step=0;
        if (i==0) {
            step=num/32.0;
            beforNum=num;
        }else{
            step=(num-beforNum)/32.0;
        }
        for (int j=0; j<32; j++) {
            int newNum=0;
            if (i==0) {
                newNum = (int)(j*step);
            }else{
                newNum = (int)(beforNum+j*step);
            }
            NSString *newNumStr=[NSString stringWithFormat:@"%d",newNum];
            [colorArray addObject:newNumStr];
        }
        beforNum=num;
    }
    for (int h=0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h*width+w;//表示第几行第几个像素
            //像素RGBA = 4b
            unsigned char bitMapRed = *(imageData + imageIndex*4);//通过指针偏移获取
            unsigned char bitMapGreen = *(imageData + imageIndex*4+1);
            unsigned char bitMapBlue = *(imageData + imageIndex*4+2);
            //colorArray:index 0-255 value;value 就是新的rgb值。
            NSString *redStr=[colorArray objectAtIndex:bitMapRed];
            NSString *greenStr=[colorArray objectAtIndex:bitMapGreen];
            NSString *blueStr=[colorArray objectAtIndex:bitMapBlue];
            unsigned char bitMapRedNew = redStr.intValue;
            unsigned char bitMapGreenNew = greenStr.intValue;
            unsigned char bitMapBlueNew = blueStr.intValue;
            memset(resultData+imageIndex*4, bitMapRedNew, 1);
            memset(resultData+imageIndex*4+1, bitMapGreenNew, 1);
            memset(resultData+imageIndex*4+2, bitMapBlueNew, 1);
        }
    }
    return resultData;
}
@end
