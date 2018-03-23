//
//  UIImage+Handle.h
//  TravelConverge
//
//  Created by ghwang on 2017/1/4.
//  Copyright © 2017年 ghwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(size)
- (UIImage *)resize:(CGSize)newSize;
- (UIImage *)fixOrientation;
- (NSData *)zipImageWithImage:(UIImage *)image;

- (UIImage *)imageThen:(UIImage *)image;
@end
