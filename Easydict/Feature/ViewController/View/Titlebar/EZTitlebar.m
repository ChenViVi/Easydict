//
//  EZTitlebar.m
//  Easydict
//
//  Created by tisfeng on 2022/11/19.
//  Copyright © 2022 izual. All rights reserved.
//

#import "EZTitlebar.h"
#import "EZTitleBarMoveView.h"
#import "NSObject+EZWindowType.h"
#import "NSImage+EZResize.h"
#import "NSObject+EZDarkMode.h"
#import "EZBaseQueryWindow.h"
#import "EZConfiguration.h"
#import "Easydict-Swift.h"

@interface EZTitlebar ()

@end

@implementation EZTitlebar

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //    EZTitleBarMoveView *moveView = [[EZTitleBarMoveView alloc] init];
    //    moveView.wantsLayer = YES;
    //    moveView.layer.backgroundColor = NSColor.clearColor.CGColor;
    //    [self addSubview:moveView];
    //    [moveView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self);
    //    }];
    
    EZOpenLinkButton *pinButton = [[EZOpenLinkButton alloc] init];
    [self addSubview:pinButton];
    self.pinButton = pinButton;
    pinButton.contentTintColor = [NSColor clearColor];
    pinButton.clickBlock = nil;
    self.pin = NO;
    
    mm_weakify(self);
    [pinButton setMouseDownBlock:^(EZButton *_Nonnull button) {
        //  NSLog(@"pin mouse down, state: %ld", button.buttonState);
        mm_strongify(self);
        self.pin = !self.pin;
    }];
    
    [pinButton setMouseUpBlock:^(EZButton *_Nonnull button) {
        //  NSLog(@"pin mouse up, state: %ld", button.buttonState);
        mm_strongify(self);
        BOOL oldPin = !self.pin;
        
        // This means clicked pin button.
        if (button.state == EZButtonHoverState) {
            self.pin = !oldPin;
        } else if (button.buttonState == EZButtonNormalState) {
            self.pin = oldPin;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateConstraints) name:EZQuickLinkButtonUpdateNotification object:nil];
}

- (void)updateConstraints {
    CGFloat kButtonWidth_24 = 24;
    CGFloat kImagenWidth_20 = 20;
    CGFloat kButtonPadding_4 = 4;
    
    CGSize buttonSize = CGSizeMake(kButtonWidth_24, kButtonWidth_24);
    CGSize imageSize = CGSizeMake(kImagenWidth_20, kImagenWidth_20);
    
    [self.pinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat pinButtonWidth = 24;
        make.width.height.mas_equalTo(pinButtonWidth);
        make.left.inset(11);
        make.top.equalTo(self).offset(EZTitlebarHeight_28 - pinButtonWidth);
    }];
    
    [self.googleButton removeFromSuperview];
    [self.eudicButton removeFromSuperview];
    [self.appleDictionaryButton removeFromSuperview];
    
    NSView *lastView;
    CGFloat quickLinkButtonTopOffset = EZTitlebarHeight_28 - kButtonWidth_24;
    CGFloat quickLinkButtonRightOffset = 12;
    
    // TODO: We should refactor it later.
    
    // Google
    if (Configuration.shared.showGoogleQuickLink) {
        EZOpenLinkButton *googleButton = [[EZOpenLinkButton alloc] init];
        [self addSubview:googleButton];
        self.googleButton = googleButton;
        self.favoriteButton = googleButton;
        
        googleButton.link = EZGoogleWebSearchURL;
        googleButton.image = [[NSImage imageNamed:@"google_icon"] resizeToSize:imageSize];
        googleButton.toolTip = [NSString stringWithFormat:@"%@, %@", NSLocalizedString(@"open_in_google", nil), @" ⌘+⏎"];
        googleButton.contentTintColor = NSColor.clearColor;
        
        [googleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(quickLinkButtonTopOffset);
            make.size.mas_equalTo(buttonSize);
            if (lastView) {
                make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
            } else {
                make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
            }
        }];
        lastView = googleButton;
    }
    
    // Apple Dictionary
    if (Configuration.shared.showAppleDictionaryQuickLink) {
        EZOpenLinkButton *appleDictButton = [[EZOpenLinkButton alloc] init];
        [self addSubview:appleDictButton];
        self.appleDictionaryButton = appleDictButton;
        self.favoriteButton = appleDictButton;
        
        appleDictButton.link = EZAppleDictionaryAppURLScheme;
        appleDictButton.image = [[NSImage imageNamed:EZServiceTypeAppleDictionary] resizeToSize:imageSize];
        appleDictButton.toolTip = [NSString stringWithFormat:@"%@, %@", NSLocalizedString(@"open_in_apple_dictionary", nil), @"⌘+⇧+D"];
        appleDictButton.contentTintColor = NSColor.clearColor;
        
        [appleDictButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(quickLinkButtonTopOffset);
            make.size.mas_equalTo(buttonSize);
            if (lastView) {
                make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
            } else {
                make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
            }
        }];
        lastView = appleDictButton;
    }
    
    EZOpenLinkButton *screenOcrSilentButton = [[EZOpenLinkButton alloc] init];
    [self addSubview:screenOcrSilentButton];
    screenOcrSilentButton.image = [[NSImage imageWithSystemSymbolName:@"dot.viewfinder" accessibilityDescription:nil] resizeToSize:imageSize];
    screenOcrSilentButton.contentTintColor = NSColor.clearColor;
    [screenOcrSilentButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(quickLinkButtonTopOffset);
        make.size.mas_equalTo(buttonSize);
        if (lastView) {
            make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
        } else {
            make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
        }
    }];
    lastView = screenOcrSilentButton;
    [screenOcrSilentButton setClickBlock:^(EZButton *_Nonnull button) {
        [[EZWindowManager shared] screenshotOCR];
    }];
    
    
    EZOpenLinkButton *pasteboardButton = [[EZOpenLinkButton alloc] init];
    [self addSubview:pasteboardButton];
    pasteboardButton.image = [[NSImage imageWithSystemSymbolName:@"highlighter" accessibilityDescription:nil] resizeToSize:imageSize];
    pasteboardButton.contentTintColor = NSColor.clearColor;
    [pasteboardButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(quickLinkButtonTopOffset);
        make.size.mas_equalTo(buttonSize);
        if (lastView) {
            make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
        } else {
            make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
        }
    }];
    lastView = pasteboardButton;
    [pasteboardButton setClickBlock:^(EZButton *_Nonnull button) {
        [[EZWindowManager shared] pasteboardTextTranslate];
    }];
    
    EZOpenLinkButton *screenOcrButton = [[EZOpenLinkButton alloc] init];
    [self addSubview:screenOcrButton];
    screenOcrButton.image = [[NSImage imageWithSystemSymbolName:@"camera.viewfinder" accessibilityDescription:nil] resizeToSize:imageSize];
    screenOcrButton.contentTintColor = NSColor.clearColor;
    [screenOcrButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(quickLinkButtonTopOffset);
        make.size.mas_equalTo(buttonSize);
        if (lastView) {
            make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
        } else {
            make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
        }
    }];
    lastView = screenOcrButton;
    [screenOcrButton setClickBlock:^(EZButton *_Nonnull button) {
        [[EZWindowManager shared] snipTranslate];
    }];
    
    EZOpenLinkButton *settingButton = [[EZOpenLinkButton alloc] init];
    [self addSubview:settingButton];
    settingButton.image = [[NSImage imageWithSystemSymbolName:@"gear" accessibilityDescription:nil] resizeToSize:imageSize];
    settingButton.contentTintColor = NSColor.clearColor;
    [settingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(quickLinkButtonTopOffset);
        make.size.mas_equalTo(buttonSize);
        if (lastView) {
            make.right.equalTo(lastView.mas_left).offset(-kButtonPadding_4);
        } else {
            make.right.equalTo(self).offset(-quickLinkButtonRightOffset);
        }
    }];
    lastView = settingButton;
    [settingButton setClickBlock:^(EZButton *_Nonnull button) {
        [NSApp activateIgnoringOtherApps:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationOpenSettingWindow" object:nil];
    }];
    
    [super updateConstraints];
}

- (void)updatePinButtonImage {
    CGFloat imageWidth = 18;
    CGSize imageSize = CGSizeMake(imageWidth, imageWidth);
    
    // Since the system's dark picture mode cannot dynamically follow the mode switch changes, we manually implement dark mode picture coloring.
    NSColor *pinNormalLightTintColor = [NSColor mm_colorWithHexString:@"#797A7F"];
    NSColor *pinNormalDarkTintColor = [NSColor mm_colorWithHexString:@"#C0C1C4"];
    
    NSImage *normalLightImage = [[NSImage imageWithSystemSymbolName:@"pin" accessibilityDescription:@"Float"] resizeToSize:imageSize];
    normalLightImage = [normalLightImage imageWithTintColor:pinNormalLightTintColor];
    NSImage *normalDarkImage = [normalLightImage imageWithTintColor:pinNormalDarkTintColor];
    
    NSImage *selectedImage = [[[NSImage imageWithSystemSymbolName:@"pin" accessibilityDescription:@"Float"] imageWithTintColor:[NSColor blueColor]] resizeToSize:imageSize];
    
    mm_weakify(self);
    [self.pinButton excuteLight:^(EZHoverButton *button) {
        mm_strongify(self)
        NSImage *image = self.pin ? selectedImage : normalLightImage;
        button.image = image;
    } dark:^(EZHoverButton *button) {
        mm_strongify(self)
        NSImage *image = self.pin ? selectedImage : normalDarkImage;
        button.image = image;
    }];
}


#pragma mark - Setter && Getter

- (BOOL)pin {
    EZBaseQueryWindow *window = (EZBaseQueryWindow *)self.window;
    return window.pin;
}

- (void)setPin:(BOOL)pin {
    EZBaseQueryWindow *window = (EZBaseQueryWindow *)self.window;
    window.pin = pin;
    NSString *shortcut = @"⌘+P";
    NSString *action = pin ? NSLocalizedString(@"unpin", nil) : NSLocalizedString(@"pin", nil);
    self.pinButton.toolTip = [NSString stringWithFormat:@"%@, %@", action, shortcut];
    
    [self updatePinButtonImage];
}

/// Check if installed app according to bundle id array
- (BOOL)checkInstalledApp:(NSArray<NSString *> *)bundleIds {
    for (NSString *bundleId in bundleIds) {
        if ([[NSWorkspace sharedWorkspace] URLForApplicationWithBundleIdentifier:bundleId]) {
            return YES;
        }
    }
    return NO;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
