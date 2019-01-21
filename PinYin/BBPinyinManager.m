//
//  BBPinyinManager.m
//  PinYin
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import "BBPinyinManager.h"

@implementation BBPinyinManager

//单例
+ (BBPinyinManager *)sharedManager{
    static BBPinyinManager *manager = nil;
    static dispatch_once_t once_t   = 0;
    dispatch_once(&once_t, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

//汉字转化成字母
- (NSString *)convertChinese:(NSString *)word{
    if(!word.length){return @"#";}
    
    NSString *first = (word.length == 1) ? word : [word substringToIndex:1];
    
    //查看是否是特殊字符
    NSString *special = [self identifySpecialWord:first];
    if(special){return special;}
    
    //查看是否是属于多音字范畴
    NSString *complex = [self complexChinese:word];
    if(complex){return complex;}
    
    //就是普通汉字了
    NSMutableString *mut = [first mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)mut, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)mut, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return mut ? [[mut substringToIndex:1] uppercaseString] : @"#";
}

/*
    多音字单独处理；
    用作姓氏的汉字一共大概五千来个；
    其中是多音字，且做姓氏时的声母与不做姓氏时声明还不同的，大概就十几个；
    目前下面收录的已经足够满足需求了。
    如果将来开发者有发现新的不在下面方法里的，请补充。
*/
- (NSString *)complexChinese:(NSString *)word{
    if([word isEqualToString:@"曾"]){return @"Z";}
    if([word isEqualToString:@"翟"]){return @"Z";}
    if([word isEqualToString:@"覃"]){return @"Q";}
    if([word isEqualToString:@"尉"]){return @"Y";}
    if([word isEqualToString:@"仇"]){return @"Q";}
    if([word isEqualToString:@"长"]){return @"Z";}
    if([word isEqualToString:@"单"]){return @"S";}
    if([word isEqualToString:@"解"]){return @"X";}
    if([word isEqualToString:@"隗"]){return @"K";}
    if([word isEqualToString:@"查"]){return @"Z";}
    return nil;
}

//特殊符号，返回#
- (NSString *)identifySpecialWord:(NSString *)word{
    unichar index = [word characterAtIndex:0];
    
    if(index >= 'a' && index <= 'z'){return word.uppercaseString;}
    if(index >= 'A' && index <= 'Z'){return word;}
    if(index <= 0x4e00 || index >= 0x9fff){return @"#";}
    
    return nil;
}

@end
