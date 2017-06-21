#import "CJActionSheetPicker.h"

#import <React/RCTConvert.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>

#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"

@implementation CJActionSheetPicker

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(showStringPicker:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    UIViewController *controller = RCTPresentedViewController();
    if (controller == nil) {
        RCTLogError(@"Tried to display action sheet but there is no application window. options: %@", options);
        return;
    }
    
    UIView *sourceView = controller.view;
    
    NSString *title = @"";
    if (options[@"title"]) {
        title = [RCTConvert NSString:options[@"title"]];
    }
    
    
    NSArray *rows = [RCTConvert NSArray:options[@"rows"]];
    
    void(^cancelBlock)(AbstractActionSheetPicker *) = ^(AbstractActionSheetPicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };
    
    AbstractActionSheetPicker *picker;
    
    NSInteger *selectedIndex = nil;
    if (options[@"selectedIndex"]) {
        selectedIndex = [RCTConvert NSInteger:options[@"selectedIndex"]];
    }
    
    void(^doneBlock)(ActionSheetStringPicker *, NSInteger, id) = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        resolve(@{
                  @"cancelled": @NO,
                  @"selectedIndex": @(selectedIndex),
                  @"selectedValue": (NSString *)selectedValue
                  });
    };
    
    picker = [[ActionSheetStringPicker alloc] initWithTitle:title
                                                       rows:rows
                                           initialSelection:selectedIndex
                                                  doneBlock:doneBlock
                                                cancelBlock:cancelBlock
                                                     origin:sourceView];
    
    // disable popover for now to support ipad.
    picker.popoverDisabled = true;
    
    [picker showActionSheetPicker];
}

RCT_EXPORT_METHOD(showDatePicker:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    UIViewController *controller = RCTPresentedViewController();
    if (controller == nil) {
        RCTLogError(@"Tried to display action sheet but there is no application window. options: %@", options);
        return;
    }
    
    UIView *sourceView = controller.view;
    
    NSString *title = @"";
    if (options[@"title"]) {
        title = [RCTConvert NSString:options[@"title"]];
    }
    
    void(^doneBlock)(ActionSheetDatePicker *, id, id) = ^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        resolve(@{ @"cancelled": @NO, @"date": selectedDate });
    };
    
    void(^cancelBlock)(ActionSheetDatePicker *) = ^(ActionSheetDatePicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:nil
                                                                           doneBlock:doneBlock
                                                                         cancelBlock:cancelBlock
                                                                              origin:sourceView];
    
    // disable popover for now to support ipad.
    datePicker.popoverDisabled = true;
    
    [datePicker showActionSheetPicker];
    
}


RCT_EXPORT_METHOD(showTimePicker:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    UIViewController *controller = RCTPresentedViewController();
    if (controller == nil) {
        RCTLogError(@"Tried to display action sheet but there is no application window. options: %@", options);
        return;
    }
    
    UIView *sourceView = controller.view;
    
    NSString *title = @"";
    if (options[@"title"]) {
        title = [RCTConvert NSString:options[@"title"]];
    }
    
    void(^doneBlock)(ActionSheetDatePicker *, id, id) = ^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        resolve(@{ @"cancelled": @NO, @"time": selectedDate });
    };
    
    void(^cancelBlock)(ActionSheetDatePicker *) = ^(ActionSheetDatePicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                      datePickerMode:UIDatePickerModeTime
                                                                        selectedDate:nil
                                                                           doneBlock:doneBlock
                                                                         cancelBlock:cancelBlock
                                                                              origin:sourceView];
    
    // disable popover for now to support ipad.
    datePicker.popoverDisabled = true;
    
    [datePicker showActionSheetPicker];
    
}

RCT_EXPORT_METHOD(showCountDownPicker:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    UIViewController *controller = RCTPresentedViewController();
    if (controller == nil) {
        RCTLogError(@"Tried to display action sheet but there is no application window. options: %@", options);
        return;
    }
    
    UIView *sourceView = controller.view;
    
    NSString *title = @"";
    if (options[@"title"]) {
        title = [RCTConvert NSString:options[@"title"]];
    }
    
    void(^doneBlock)(ActionSheetDatePicker *, id, id) = ^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        resolve(@{ @"cancelled": @NO, @"countDownDuration": selectedDate });
    };
    
    void(^cancelBlock)(ActionSheetDatePicker *) = ^(ActionSheetDatePicker *picker) {
        resolve(@{ @"cancelled": @YES });
    };
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:title
                                                                      datePickerMode:UIDatePickerModeCountDownTimer
                                                                        selectedDate:nil
                                                                           doneBlock:doneBlock
                                                                         cancelBlock:cancelBlock
                                                                              origin:sourceView];
    
    if (options[@"countDownDuration"]) {
        datePicker.countDownDuration = [RCTConvert double:options[@"countDownDuration"]];
    }
    
    // disable popover for now to support ipad.
    datePicker.popoverDisabled = true;
    
    [datePicker showActionSheetPicker];
}

@end
