import Flutter
import UIKit

public class SwiftInputBoxWithSuggestionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "input_box_with_suggestion", binaryMessenger: registrar.messenger())
    let instance = SwiftInputBoxWithSuggestionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
