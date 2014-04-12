//Copyright (c) 2014 Martin Hartl <martin@mhaddl.me>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "MHSegmentedView.h"

@interface MHSegmentedView ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *container;

@end

@implementation MHSegmentedView


- (void)setup {
    [self setupSegmentedControl];
    [self setupContainer];
    
    self.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < [self.delegate numberOfSegmentsInSegmentedView:self]; i++) {
        [self.segmentedControl insertSegmentWithTitle:[self.delegate titleForSegmentAtIndex:i inSegmentedView:self] atIndex:i animated:NO];
        UIView *view = [self.delegate viewForSegmentIndex:i inSegmentedView:self];
        [self.container addSubview:view];
        [self applyContainerConstraintsToView:view];
    }
    
    self.segmentedControl.selectedSegmentIndex = 0;
    [self segmentChangeAction:self.segmentedControl];
    
}

- (void)refresh {
    [self setup];
}

- (void)setDelegate:(id<MHSegmentedViewDelegate>)delegate {
    _delegate = delegate;
    [self setup];
}

- (void)setupSegmentedControl {
    self.segmentedControl = [[UISegmentedControl alloc] init];
    [self.segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.segmentedControl addTarget:self action:@selector(segmentChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentedControl];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:22];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.segmentedControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    [self.segmentedControl addConstraint:heightConstraint];
    [self addConstraints:@[leadingConstraint,topConstraint, trailingConstraint]];
    [self.segmentedControl layoutIfNeeded];
}

- (void)setupContainer {
    self.container = [[UIView alloc] init];
    self.container.backgroundColor = [UIColor clearColor];
    [self addSubview:self.container];
    [self applyContainerConstraintsToView:self.container];
}

- (void)applyContainerConstraintsToView:(UIView *)view {
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.segmentedControl attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [self addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    [view layoutIfNeeded];
}

- (void)segmentChangeAction:(UISegmentedControl *)sender {
    UIView *foremost = self.container.subviews.lastObject;
    foremost.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(segmentedView:didSelectSegmentAtIndex:)]) {
        [self.delegate segmentedView:self didSelectSegmentAtIndex:sender.selectedSegmentIndex];
    }
    
    UIView *next = [self.delegate viewForSegmentIndex:sender.selectedSegmentIndex inSegmentedView:self];
    next.hidden = NO;
    [self.container bringSubviewToFront:next];
}

#pragma mark - Style

- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state {
    [self.segmentedControl setTitleTextAttributes:attributes forState:state];
    [self.segmentedControl layoutIfNeeded];
}

@end
