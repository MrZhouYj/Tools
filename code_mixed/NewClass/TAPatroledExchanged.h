//
//  TAPatroledExchanged.h
//  JLGP
//
//   9/29.
//  Copyright © 2019 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define    PATH_CHATREC_IMAGE    [PATH_DOCUMENT stringByAppendingPathComponent:@"Chat/Images"]

NS_ASSUME_NONNULL_BEGIN

typedef void (^TAPatroledExchangedBlock)(UIImage *image);

@interface TAPatroledExchanged : NSObject

+(instancetype)shareImgaePicker;

- (void)getPhotoAlbumOrTakeAPhotoWithController:(UIViewController *)controller photoBlock:(TAPatroledExchangedBlock)photoBlock;

-(void)getPhotoByTakeAPhotoBlock:(TAPatroledExchangedBlock)photoBlock;

-(void)getPhotoInAlbumPhotoBlock:(TAPatroledExchangedBlock)photoBlock;



@end

NS_ASSUME_NONNULL_END
