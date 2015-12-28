![image](https://github.com/tiger8888/WHUPopView/blob/master/WHUPopView_Demo.gif)

####仿淘宝选择窗口的弹出样式
---
弹出:
```objc
- (IBAction)btnAction:(id)sender {
    UIImageView* imgview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Professortocat_v2"]];
    imgview.backgroundColor=[UIColor blueColor];
    [[WHUPopViewManager manager] showWithView:imgview height:250];
}
```

隐藏:
```objc
    [[WHUPopViewManager manager] dismiss];
```



---
感谢桦木沉海童鞋的无私帮助!!!!!
