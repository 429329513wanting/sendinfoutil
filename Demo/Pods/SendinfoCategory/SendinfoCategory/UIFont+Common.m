//
//  UIFont+Common.m
//  UCForWorldShop
//
//  Created by ghwang on 2017/3/21.
//  Copyright © 2017年 ghwang. All rights reserved.
//

#import "UIFont+Common.h"

@implementation UIFont(Common)


+ (UIFont *)titleFont{

    return [UIFont systemFontOfSize:18];
}

+ (UIFont *)commonFont{
    
    return [UIFont systemFontOfSize:16];
}
+ (UIFont *)commonFontSmall{
    
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)smallFont{
    
    return [UIFont systemFontOfSize:13];
}
+ (UIFont *)smallerFont{
    
    return [UIFont systemFontOfSize:12];
}
+ (UIFont *)smallerLessthanFont{
    
    return [UIFont systemFontOfSize:11];
}

@end
