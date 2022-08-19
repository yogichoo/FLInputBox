//
//  UITextField+DeleteKey.m
//  FLInputBox
//
//  Created by sashy on 2022/8/19.
//

#import "UITextField+DeleteKey.h"
#import <objc/runtime.h>

@implementation UITextField (DeleteKey)

+ (void)load {
    //Hook 交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(FLProgram_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)FLProgram_deleteBackward {
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        id delegate = (id)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }else {
        Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
        Method method2 = class_getInstanceMethod([self class], @selector(FLProgram_deleteBackward));
        //如果没有实现代理方法，复原
        method_exchangeImplementations(method2, method1);
    }
}

@end
