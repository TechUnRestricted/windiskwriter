//
//  VerticalStackLayout.m
//  WinDiskWriter GUI
//
//  Created by Macintosh on 26.02.2023.
//  Copyright © 2023 TechUnRestricted. All rights reserved.
//

#import "VerticalStackLayout.h"
#import "NSView+QuickConstraints.h"

StackLayoutConstraintIdentifier const StackLayoutConstraintIdentifierBottom = @"bottom";
StackLayoutConstraintIdentifier const StackLayoutConstraintIdentifierBottomWeak = @"bottomWeak";

@implementation VerticalStackLayout

- (void)addView: (NSView *_Nonnull)newView
        spacing: (CGFloat)spacing {
    [newView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    [self.containerView addSubview:newView];
    
    [newView setConstraintAttribute:NSLayoutAttributeLeading toItem:self.containerView itemAttribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual isWeak:NO constant:0 multiplier:1.0 identifier:NULL];
    [newView setConstraintAttribute:NSLayoutAttributeTrailing toItem:self.containerView itemAttribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual isWeak:YES constant:0 multiplier:1.0 identifier:NULL];
    [newView setConstraintAttribute:NSLayoutAttributeTrailing toItem:self.containerView itemAttribute:NSLayoutAttributeTrailing relation:NSLayoutRelationLessThanOrEqual isWeak:NO constant:0 multiplier:1.0 identifier:NULL];
    
    if (self.containerView.subviews.count <= 1) {
        [newView setConstraintAttribute:NSLayoutAttributeTop toItem:self.containerView itemAttribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual isWeak:NO constant:spacing multiplier:1.0 identifier:NULL];
 
    } else {
        NSView *previousView = [self.containerView.subviews objectAtIndex: (self.containerView.subviews.count - 2)];
        NSArray *parentLayoutConstraints = self.containerView.constraints;
        
        BOOL bottomRemoved = NO;
        BOOL weakBottomRemoved = NO;
        
        for (NSInteger i = parentLayoutConstraints.count - 1; i >= 0; --i) {
            NSLayoutConstraint *currentConstraint = [parentLayoutConstraints objectAtIndex:i];
            
            if (bottomRemoved && weakBottomRemoved) {
                break;
            }
            
            if (![currentConstraint.firstItem isEqual:previousView]) {
                continue;
            }
            
            if (currentConstraint.identifier == StackLayoutConstraintIdentifierBottom) {
                [self.containerView removeConstraint:currentConstraint];
                bottomRemoved = YES;
                continue;
            }
            
            if (currentConstraint.identifier == StackLayoutConstraintIdentifierBottomWeak) {
                [self.containerView removeConstraint:currentConstraint];
                weakBottomRemoved = YES;
                continue;
            }
        }
        
        [newView setConstraintAttribute:NSLayoutAttributeTop toItem:previousView itemAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual isWeak:NO constant:spacing multiplier:1.0 identifier:NULL];
        
    }
    
    [self.containerView setConstraintAttribute:NSLayoutAttributeBottom toItem:newView itemAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual isWeak:YES constant:spacing multiplier:1.0 identifier:StackLayoutConstraintIdentifierBottomWeak];
    [self.containerView setConstraintAttribute:NSLayoutAttributeBottom toItem:newView itemAttribute:NSLayoutAttributeBottom relation:NSLayoutRelationGreaterThanOrEqual isWeak:NO constant:spacing multiplier:1.0 identifier:StackLayoutConstraintIdentifierBottom];

}





@end