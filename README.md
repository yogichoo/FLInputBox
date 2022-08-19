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
<img width="340" alt="image" src="https://user-images.githubusercontent.com/16301241/185619340-2439cd7b-10b9-4033-ba71-354eda02f760.png">
