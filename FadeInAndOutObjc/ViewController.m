//
//  ViewController.m
//  FadeInAndOutObjc
//
//  Created by Presley Cannady on 12/4/15.
//  Copyright © 2015 Universal Secure Registry, LLC. All rights reserved.
//

#import "ViewController.h"

dispatch_source_t CreateDispatchTimer(double interval
                                      , dispatch_queue_t queue
                                      , dispatch_block_t block) {
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER
                                                     , 0
                                                     , 0
                                                     , queue);
    
    if (timer) {
        dispatch_source_set_timer(timer
                                  , dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC)
                                  , interval * NSEC_PER_SEC
                                  , (1ull * NSEC_PER_SEC) / 10);
        
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
        
}

@interface ViewController () {
    
    dispatch_source_t _timer;
    
}

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];

    self.fadeLabel.alpha = 0;
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
