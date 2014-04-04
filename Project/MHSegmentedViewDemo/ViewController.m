//
//  ViewController.m
//  MHSegmentedViewDemo
//
//  Created by Martin Hartl on 02/12/13.
//  Copyright (c) 2013 Martin Hartl. All rights reserved.
//

#import "ViewController.h"
#import "MHSegmentedView.h"

@interface ViewController () <MHSegmentedViewDelegate>

@property (weak, nonatomic) IBOutlet MHSegmentedView *segmentedView;

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;
@property (strong, nonatomic) UIView *view3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view1 = [[UIView alloc] init];
    self.view2 = [[UIView alloc] init];
    self.view3 = [[UIView alloc] init];
    
    self.view1.backgroundColor = [UIColor greenColor];
    self.view2.backgroundColor = [UIColor redColor];
    self.view3.backgroundColor = [UIColor blueColor];
    
    self.segmentedView.delegate = self;
}

#pragma mark - MTSegmentedViewDelegate

- (UIView *)viewForSegmentIndex:(NSInteger)index inSegmentedView:(MHSegmentedView *)segmentedView {
    switch (index) {
        case 0:
            return self.view1;
            break;
        case 1:
            return self.view2;
            break;
        case 2:
            return self.view3;
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfSegmentsInSegmentedView:(MHSegmentedView *)segmentedView {
    return 3;
}

- (NSString *)titleForSegmentAtIndex:(NSInteger)index inSegmentedView:(MHSegmentedView *)segmentedView {
    return [NSString stringWithFormat:@"View - %ld", (long)index];
}

- (void)segmentedView:(MHSegmentedView *)segmentedView didSelectSegmentAtIndex:(NSInteger)index {
    NSLog(@"did select: %ld", (long)index);
}

@end
