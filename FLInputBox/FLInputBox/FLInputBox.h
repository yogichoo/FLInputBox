//
//  FLInputBox.h
//  FLProgram
//
//  Created by teamotto iOS on 2020/5/19.
//  Copyright © 2020 yogichoo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//array：由每格的值对应组成的数组
//value: 由每格的值组成的字符串
typedef void (^FLInputBoxBlock) (NSArray * _Nullable array, NSString * _Nullable value);

@interface FLInputBox : UIView

//输入框数量(默认：4)
@property (assign, nonatomic) NSInteger boxNumber;
//每个输入框输入的字数(默认：1)
@property (assign, nonatomic) NSInteger wordCount;
//输入框间距(默认：10)
@property (assign, nonatomic) CGFloat boxSpace;

//设置输入框每格的背景颜色
- (void)setInputBoxColor:(UIColor *)color;
//设置输入框字体
- (void)setInputBoxFont:(UIFont *)font;
//设置输入框字体颜色
- (void)setInputBoxTextColor:(UIColor *)color;
//视图点击事件
- (void)action:(FLInputBoxBlock)block;

@end

NS_ASSUME_NONNULL_END
