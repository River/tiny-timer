//
//  StatusItemPopup.h
//  StatusItemPopup
//
//  Created by Alexander Schuch on 06/03/13.
//  Copyright (c) 2013 Alexander Schuch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AXStatusItemPopup : NSView <NSPopoverDelegate>

// properties
@property(assign, nonatomic, getter=isActive) BOOL active;
@property(assign, nonatomic) BOOL animated;
@property(strong, nonatomic) NSImage *image;
@property(strong, nonatomic) NSImage *alternateImage;


// init
- (id)initWithViewController:(NSViewController *)controller;
- (id)initWithViewController:(NSViewController *)controller image:(NSImage *)image;
- (id)initWithViewController:(NSViewController *)controller image:(NSImage *)image alternateImage:(NSImage *)alternateImage;
- (id)initWithViewController:(NSViewController *)controller image:(NSImage *)image alternateImage:(NSImage *)alternateImage label:(NSString *)label;

- (void) setStatusBarTitle: (NSString *)title;

// show / hide popover
- (void)showPopover;
- (void)showPopoverAnimated:(BOOL)animated;
- (void)hidePopover;

@end
