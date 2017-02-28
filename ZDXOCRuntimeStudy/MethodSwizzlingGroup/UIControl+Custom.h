//
//  UIControl+Custom.h
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/27.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Custom)

@property (nonatomic,assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔

@end
