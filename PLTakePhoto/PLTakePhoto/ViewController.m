//
//  ViewController.m
//  PLTakePhoto
//
//  Created by panglong on 15/12/14.
//  Copyright © 2015年 庞龙. All rights reserved.
//

#import "ViewController.h"
#import "CorePhotoPickerVCManager.h"

@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"请选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"照片库",@"照片多选", nil];
    
    [sheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    CorePhotoPickerVCMangerType type=0;
    
    
    if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeCamera;
    
    if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeSinglePhoto;
    
    if(buttonIndex==2) type=CorePhotoPickerVCMangerTypeMultiPhoto;
    
    if(buttonIndex==3) return;
    
    CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
    
    //设置类型
    manager.pickerVCManagerType=type;
    
    //最多可选3张
    manager.maxSelectedPhotoNumber=5;
    
    //错误处理
    if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
        NSLog(@"设备不可用");
        return;
    }
    
    UIViewController *pickerVC=manager.imagePickerController;
    
    //选取结束
    manager.finishPickingMedia=^(NSArray *medias){
        
        [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
            NSLog(@"%@",photo.editedImage);
        }];
    };
    
    [self presentViewController:pickerVC animated:YES completion:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
