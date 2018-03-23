//
//  UIColor+Utilty.m
//  RentBusiness
//
//  Created by ghwang on 2017/11/10.
//  Copyright © 2017年 ghwang. All rights reserved.
//

#import "UIColor+Utilty.h"
#import "UIColor+PGHex.h"

@implementation UIColor(Utility)

+(UIColor *)navBarColor{
    
    return [UIColor colorWithHexString:@"#2fbee6"];
}

+ (UIColor *)btnMainColor{
    
    return [UIColor colorWithHexString:@"#2fbee6"];
}

+ (UIColor *)textTitleColor{
    
    return [UIColor colorWithHexString:@"#000"];
}
+ (UIColor *)textGeneralColor{
    
    return [UIColor colorWithHexString:@"#a4a5a6"];
}
+ (UIColor *)textPlaceHolderColor{
    
    return [UIColor colorWithHexString:@"#4a4a4a"];
}
+ (UIColor *)textPriceColor{
    
    return [UIColor colorWithHexString:@"#faa35e"];

}
+ (UIColor *)backgroundColor{
    
    return [UIColor colorWithHexString:@"#f5f5f5"];
}
+ (UIColor *)cccColor{
    
    return [UIColor colorWithHexString:@"#ccc"];
}
+ (UIColor *)lineColor{
    
    return [UIColor colorWithHexString:@"#ececec"];
    
}
+ (UIColor *)paddingColor{
    
    return [UIColor colorWithHexString:@"#ebecf1"];
}


@end
