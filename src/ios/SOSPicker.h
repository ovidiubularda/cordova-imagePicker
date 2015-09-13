//
//  SOSPicker.h
//  SyncOnSet
//
//  Created by Ovidiu Bularda
//
//

#import <Cordova/CDVPlugin.h>
#import "QBImagePicker.h"

@interface SOSPicker : CDVPlugin <QBImagePickerControllerDelegate>

@property (copy) NSString* callbackId;

- (void) getPictures:(CDVInvokedUrlCommand *)command;
- (UIImage*)imageByScalingNotCroppingForSize:(UIImage*)anImage toSize:(CGSize)frameSize;

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger quality;
@property (nonatomic, assign) NSInteger dataurl;

- (NSString *)encodeToBase64String:(UIImage *)image;

@end
