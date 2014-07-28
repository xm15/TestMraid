//
//  RootVC.m
//  TestMraid
//
//  Created by caigee on 14-7-28.
//  Copyright (c) 2014年 caigee. All rights reserved.
//

#import "RootVC.h"


@interface RootVC ()
{
    
}

@end

@implementation RootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MraidView *mrView = [[MraidView alloc]initWithFrame:CGRectMake(0.0, 200, 320.0, 50.0)];
    [self.view addSubview:mrView];
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
