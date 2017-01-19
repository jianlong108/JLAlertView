# JLAlertView
very similar with UIAlertView,but JLAlertView is not subclass of UIAlertView

    - (void)entryAPPSTORE{
      UIAlertView *ALERT1 = [[UIAlertView alloc]initWithTitle:@"第一个" message:@"hello" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [ALERT1 show];
    
      UIAlertView *ALERT2 = [[UIAlertView alloc]initWithTitle:@"第2个" message:@"ok" delegate:self cancelButtonTitle:@"sure" otherButtonTitles:nil];
      [ALERT2 show];
    }
    - (void)entryPhotoReader{
      JLAlertView *alert = [[JLAlertView alloc]initWithTitle:@"第一个" message:@"hello" delegate:nil SureButtonTitle:@"ok" otherButtonTitles:nil];
      [alert show];
    
      JLAlertView *alert1 = [[JLAlertView alloc]initWithTitle:@"第2个" message:@"welcome" delegate:nil SureButtonTitle:@"sure" otherButtonTitles:nil];
      [alert1 show];
    }
   
![image](https://github.com/jianlong108/JLAlertView/blob/master/ezgif.com-video-to-gif%20(1).gif)
