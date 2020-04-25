//
//  ViewController.m
//  ImagePalette
//
//  Created by 颜学宙 on 2020/4/22.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "ViewController.h"
#import "ImageChangeVC.h"
#import "ImageSpecialEffectsPicture.h"
#import "SpecialEffectsPhotoVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource=@[@"图片转化",@"uiimage 特效",@"特效相机"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc=nil;
    NSInteger row=indexPath.row;
    if (row==0) {
        vc=[[ImageChangeVC alloc]init];
    }else if(row==1){
        vc=[[ImageSpecialEffectsPicture alloc]initWithNibName:@"ImageSpecialEffectsPicture" bundle:nil];
    }else if(row==2){
        vc=[[SpecialEffectsPhotoVC alloc]initWithNibName:@"SpecialEffectsPhotoVC" bundle:nil];
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
