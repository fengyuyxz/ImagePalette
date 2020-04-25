//
//  ImageChangeVC.m
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "ImageChangeVC.h"

@interface ImageChangeVC ()
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ImageChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 320)];
    [self.view addSubview:self.imageView];
//    [self showImage];
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:@"jpnToPng" forState:UIControlStateNormal];
    but.frame=CGRectMake(10, self.imageView.frame.origin.y+self.imageView.frame.size.height+10, 300, 50);
    [but setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:but];
    [but addTarget:self action:@selector(jpgToPng) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)jpgToPng{
    UIImage *image=[UIImage imageNamed:@"_MG_0668.jpg"];
    NSData *data=UIImagePNGRepresentation(image);//jpg to png
    //png to png [UIImage imageNamed:@"_MG_0668.png"];
//    UIImageJPEGRepresentation(image, 1);
    
    UIImage *pngImage=[UIImage  imageWithData:data];
    self.imageView.image=pngImage;
}
-(void)showImage{
    UIImage *image=[UIImage imageNamed:@"_MG_0668.jpg"];
    self.imageView.image=image;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
