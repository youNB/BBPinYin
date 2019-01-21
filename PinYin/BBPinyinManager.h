//
//  BBPinyinManager.h
//  PinYin
//
//  Created by 程肖斌 on 2019/1/21.
//  Copyright © 2019年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBPinyinManager : NSObject

//单例
+ (BBPinyinManager *)sharedManager;

//汉字转化成字母
- (NSString *)convertChinese:(NSString *)word;

//多音字单独处理
- (NSString *)complexChinese:(NSString *)word;

//特殊符号,返回#
- (NSString *)identifySpecialWord:(NSString *)word;

@end

