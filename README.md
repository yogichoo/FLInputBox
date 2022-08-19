# FLInputBox
```
[CGFloat height = (self.view.frame.size.width-60-(5*10))/6;
    FLInputBox *inputBox = [[FLInputBox alloc] initWithFrame:CGRectMake(30, 250, self.view.frame.size.width-60, height)];
    inputBox.boxNumber = 6;
    inputBox.wordCount = 2;
    [inputBox action:^(NSArray * _Nullable array, NSString * _Nullable value) {
        NSLog(@"array：%@ -value：%@", array, value);
    }];
    [self.view addSubview:inputBox];
```
