//
//  UIViewController+MethodSwizzling.h
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/24.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MethodSwizzling)

-(void)ZDX_viewWillAppear:(BOOL)animated;
-(void)ZDX_viewWillDisappear:(BOOL)animated;

@end
