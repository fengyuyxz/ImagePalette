//
//  SpecialEffectsPhotoVC.m
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/24.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "SpecialEffectsPhotoVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ImageSpecialEffectsAlgorithm.h"
@interface SpecialEffectsPhotoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SpecialEffectsPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)photoBut:(id)sender {
    [self configImageController];
}

-(void)configImageController{
    UIImagePickerController *controller=[[UIImagePickerController alloc]init];
    controller.sourceType=UIImagePickerControllerSourceTypeCamera;
    NSString *mediaType =(__bridge NSString *) kUTTypeImage;
    controller.mediaTypes=@[mediaType];
    controller.delegate=self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];;
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(__bridge NSString *) kUTTypeImage]) {
        UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
        unsigned char * imageData=[ImageSpecialEffectsAlgorithm convertUIImageToData:image];
        unsigned char *imageDataNew=[ImageSpecialEffectsAlgorithm imageReColorWithData:imageData width:image.size.width height:image.size.height];
        UIImage *imageNew=[ImageSpecialEffectsAlgorithm convertDataToUIImage:imageDataNew image:image];
        UIImageWriteToSavedPhotosAlbum(imageNew, nil, nil, nil);
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
