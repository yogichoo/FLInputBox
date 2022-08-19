//
//  FLInputBox.m
//  FLProgram
//
//  Created by teamotto iOS on 2020/5/19.
//  Copyright © 2020 yogichoo. All rights reserved.
//

#import "FLInputBox.h"
#import "UITextField+DeleteKey.h"

//View width
#define FLViewWidth(a) (a).frame.size.width
//View height
#define FLViewHeigth(a) (a).frame.size.height

@interface FLInputBox () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy  , nonatomic) FLInputBoxBlock block;
@property (assign, nonatomic) BOOL isEnableBlock;

@end

@implementation FLInputBox

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    //创建输入框控件
    _boxNumber = 4;
    _wordCount = 1;
    _boxSpace  = 10;
    self.isEnableBlock = NO;
    
    [self customUI];
}

- (void)customUI {
    [self removeAllInputBox];
    
    CGFloat boxWidth  = (FLViewWidth(self)-(_boxNumber-1)*_boxSpace)/_boxNumber;
    CGFloat boxHeight = FLViewHeigth(self);
    CGFloat boxX = 0;
    for (NSInteger i=0; i<_boxNumber; i++) {
        if (i != 0)
            boxX += boxWidth+_boxSpace;
        UITextField *inputTF = [[UITextField alloc] initWithFrame:CGRectMake(boxX, 0, boxWidth, boxHeight)];
        inputTF.backgroundColor = [UIColor lightGrayColor];
        inputTF.layer.cornerRadius = 3;
        inputTF.textColor = [UIColor whiteColor];
        inputTF.textAlignment = NSTextAlignmentCenter;
        inputTF.font = [UIFont systemFontOfSize:20];
        inputTF.tag = 100+i;
        inputTF.delegate = self;
        [self.dataArray addObject:inputTF];
        [self addSubview:inputTF];
    }
}

- (void)removeAllInputBox {
    if (self.dataArray.count != 0) {
        //移除原有的inputTF
        for (UITextField *inputTF in self.dataArray) {
            [inputTF removeFromSuperview];
        }
        [self.dataArray removeAllObjects];
    }
}

//重写boxNumber set方法
- (void)setBoxNumber:(NSInteger)boxNumber {
    _boxNumber = boxNumber;
    [self customUI];
}

- (void)setBoxSpace:(CGFloat)boxSpace {
    _boxSpace = boxSpace;
    [self customUI];
}

- (void)setInputBoxColor:(UIColor *)color {
    for (UITextField *inputTF in self.dataArray) {
        inputTF.backgroundColor = color;
    }
}

- (void)setInputBoxFont:(UIFont *)font {
    for (UITextField *inputTF in self.dataArray) {
        inputTF.font = font;
    }
}

- (void)setInputBoxTextColor:(UIColor *)color {
    for (UITextField *inputTF in self.dataArray) {
        inputTF.textColor = color;
    }
}

- (void)action:(FLInputBoxBlock)block {
    self.isEnableBlock = YES;
    self.block = block;
}

#pragma mark - UITextFieldDelegate
//监听键盘删除按键
- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]) {
        textField.text = @"";
    }else {
        if (textField.tag != 100) {
            UITextField *inputTF = (UITextField *)[self viewWithTag:textField.tag-1];
            [inputTF becomeFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //点击时，立即清空框内容
    textField.text = @"";
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSMutableString *inputStr = [[NSMutableString alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<_boxNumber; i++) {
        UITextField *inputTF = (UITextField *)[self viewWithTag:100+i];
        NSString *value = inputTF.text;
        [array addObject:value];
        if (![value isEqualToString:@""])
            [inputStr appendString:value];
        else
            [inputStr appendString:@" "];
    }
    if (self.isEnableBlock)
        self.block(array, inputStr);
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *inputStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([inputStr length] > self.wordCount)
        return NO;
    
    if (textField.tag != 100+(_boxNumber-1)) {
        if ([inputStr length] == self.wordCount) {
            textField.text = inputStr;
            UITextField *inputTF = (UITextField *)[self viewWithTag:textField.tag+1];
            [inputTF becomeFirstResponder];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

@end
