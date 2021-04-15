#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Canvas.h"
#import "CSAnimation.h"
#import "CSAnimationView.h"
#import "CSBlurView.h"
#import "CSNavigationController.h"
#import "UIButton+TCCustomFont.h"
#import "UILabel+TCCustomFont.h"
#import "UINavigationBar+TCCustomFont.h"
#import "UITextField+PlaceholderColor.h"
#import "UITextField+TCCustomFont.h"
#import "UITextView+TCCustomFont.h"

FOUNDATION_EXPORT double CanvasVersionNumber;
FOUNDATION_EXPORT const unsigned char CanvasVersionString[];

