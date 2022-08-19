//
//  UITextField+DeleteKey.h
//  FLInputBox
//
//  Created by sashy on 2022/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLTextFieldDelegate

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;

@end

@interface UITextField (DeleteKey)

@property (weak, nonatomic) id delegate;

@end

NS_ASSUME_NONNULL_END
