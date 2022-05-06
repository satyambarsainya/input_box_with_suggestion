#import "InputBoxWithSuggestionPlugin.h"
#if __has_include(<input_box_with_suggestion/input_box_with_suggestion-Swift.h>)
#import <input_box_with_suggestion/input_box_with_suggestion-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "input_box_with_suggestion-Swift.h"
#endif

@implementation InputBoxWithSuggestionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInputBoxWithSuggestionPlugin registerWithRegistrar:registrar];
}
@end
