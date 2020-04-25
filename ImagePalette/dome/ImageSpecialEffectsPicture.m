//
//  ImageSpecialEffectsPicture.m
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "ImageSpecialEffectsPicture.h"


#import "ImageSpecialEffectsAlgorithm.h"
@interface ImageSpecialEffectsPicture ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;

@end

@implementation ImageSpecialEffectsPicture

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    self.imageView1.image=image;
    self.imageView2.image=image;
    self.imageView3.image=image;
    self.imageView4.image=image;
    self.imageView5.image=image;
    [self converGrayTest];
    [self converReTest];
    [self converReTest2];
    [self converHightLightTest];
}
-(void)converFormatTest{
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
    UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:imageData image:image];
    self.imageView1.image=imageNew;
}
-(void)converGrayTest{
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
    unsigned char * grayData=[ImageSpecialEffectsAlgorithm imageGrayWithData:imageData width:image.size.width height:image.size.height];
    UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:grayData image:image];
    self.imageView2.image=imageNew;
    
}
-(void)converReTest{
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
    unsigned char * reData=[ImageSpecialEffectsAlgorithm imageReColorWithData:imageData width:image.size.width height:image.size.height];
    UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:reData image:image];
    self.imageView3.image=imageNew;
    
}
-(void)converReTest2{
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
    unsigned char * grayData=[ImageSpecialEffectsAlgorithm imageGrayWithData:imageData width:image.size.width height:image.size.height];
    unsigned char * reData=[ImageSpecialEffectsAlgorithm imageReColorWithData:grayData width:image.size.width height:image.size.height];
    UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:reData image:image];
    self.imageView4.image=imageNew;
    
}
-(void)converHightLightTest{
    UIImage *image=[UIImage imageNamed:@"5.jpg"];
    unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
    unsigned char * hightData=[ImageSpecialEffectsAlgorithm imageHightLightWithData:imageData width:image.size.width height:image.size.height];
    UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:hightData image:image];
    self.imageView5.image=imageNew;
    
}

@end
