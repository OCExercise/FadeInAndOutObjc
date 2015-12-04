# FadeInAndOutObjc

Quick demonstration of a pulsating fade in and out animation.  Simple to do.  Here's the gist of it.

```objc
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _timer = CreateDispatchTimer(2.0, queue, ^{
    
        dispatch_sync(dispatch_get_main_queue(), ^{
        
            if (self.fadeLabel.alpha == 1.0) {
                
                [UIView animateWithDuration:2.0 animations:^{
                    self.fadeLabel.alpha = 0;
                }];
                
            } else if (self.fadeLabel.alpha == 0) {
                
                [UIView animateWithDuration:2.0 animations:^{
                    self.fadeLabel.alpha = 1.0;
                }];
            }

        });
    });
    

}
```
