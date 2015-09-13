//
//  SOSPicker.m
//  SyncOnSet
//
//  Created by Ovidiu Bularda
//
//

#import "SOSPicker.h"


@implementation SOSPicker

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void) getPictures:(CDVInvokedUrlCommand *)command {
	
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.mediaType = QBImagePickerMediaTypeAny;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.showsNumberOfSelectedAssets = YES;

    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    NSMutableArray *resultStrings = [[NSMutableArray alloc] init];
    PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;
    
    for (PHAsset *asset in assets) {
        // Do something with the asset
        if(asset.mediaType == PHAssetMediaTypeImage)
        {
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                NSString *imgData = [self encodeToBase64String:image];
                [resultStrings addObject:imageData];
            }];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    //Run cordova
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsArray: resultStrings];
    [self.commandDelegate sendPluginResult:result callbackId: self.callbackId];

}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
