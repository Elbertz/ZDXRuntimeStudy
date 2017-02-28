//
//  Person.h
//  ZDXOCRuntimeStudy
//
//  Created by Elbert on 17/2/23.
//  Copyright © 2017年 Elbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject


@property (nonatomic,assign) char aChar;
@property (nonatomic,assign) int aInt;
@property (nonatomic,assign) short aShort;
@property (nonatomic,assign) long aLong;
@property (nonatomic,assign) long long aLLong;
@property (nonatomic,assign) float aFloat;
@property (nonatomic,assign) double aDouble;
@property (nonatomic,assign) BOOL aBool;

@property (nonatomic,retain) NSString *aString;
@property (nonatomic,retain) NSMutableString *aMString;
@property (nonatomic,retain) NSArray *aArray;
@property (nonatomic,retain) NSMutableArray *aMArray;
@property (nonatomic,retain) NSDictionary *aDictionary;
@property (nonatomic,retain) NSMutableDictionary *aMDictionary;

@property (nonatomic,retain) UILabel *aLabel;
@property (nonatomic,retain) UIButton *aButton;
@property (nonatomic,retain) UIView *aView;


- (void)eat;




@end
