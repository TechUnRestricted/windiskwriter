//
//  AdvancedTextView.h
//  WinDiskWriter GUI
//
//  Created by Macintosh on 10.08.2023.
//  Copyright © 2023 TechUnRestricted. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VibrantTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvancedTextView : NSScrollView

@property (nonatomic, strong, readonly) VibrantTextView *textViewInstance;

@property (nonatomic, readwrite) BOOL automaticallyScroll;

- (void)appendLine:(NSString *)message;

- (void)appendTimestampedLine: (NSString *)message;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
