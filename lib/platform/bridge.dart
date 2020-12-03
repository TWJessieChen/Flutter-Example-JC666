
import 'package:flutter/services.dart';

class NativeBridge {

  static const messageChannel = const MethodChannel('com.example.flutter_dart_jc666/channel');
  static const methodHello = "hello_jc666";
  static const methodChangeInternetConnectivity = "CHANGE_INTERNET";

  static const eventChannel =
        const EventChannel('com.example.flutter_dart_jc666/event_channel');

  static bool currentValue = false;
  static Stream<String> eventStream;

  static Stream<String> listenToNativeEventChannel() {
    if ( eventStream == null ) eventStream =
        eventChannel.receiveBroadcastStream().cast<String>();
    return eventStream;
  }
  
  static void changeInternetConnectivity() {
    Map<String, dynamic> params = {};

    currentValue = !currentValue;
    params["connectivity"] = currentValue;

    messageChannel.invokeMethod(methodChangeInternetConnectivity, params);
  }

  // static Future<String> changeInternetConnectivity() async {
  //   String response = "";
  //   try {
  //     final String result = await messageChannel.invokeMethod(methodChangeInternetConnectivity);
  //     response = result;
  //   } on PlatformException catch (e) {
  //     response = "Failed to Invoke: '${e.message}'.";
  //   }
  //   return response;
  // }

  static Future<String> sayHiToNative() async {
    String response = "";
    try {
      final String result = await messageChannel.invokeMethod(methodHello);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

}