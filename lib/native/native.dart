import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'Utf8.dart';

typedef reverse_func = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);


class Native {

  static final DynamicLibrary dylib = Platform.isAndroid
      ? DynamicLibrary.open("libnative.so")
      : DynamicLibrary.process();

  // static const MethodChannel _channel = const MethodChannel('native_func');
  //
  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  static int Function(int x, int y) intAdd = dylib
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("int_add")
      .asFunction();

  static double Function(double, double) doubleAdd = dylib
      .lookup<NativeFunction<Double Function(Double, Double)>>("double_add")
      .asFunction();

  static String reverseFunc(String str,int strLength) {

    final reversePointer = dylib.lookup<NativeFunction<reverse_func>>('reverse');
    final reverse = reversePointer.asFunction<Reverse>();
    return Utf8.fromUtf8(reverse(Utf8.toUtf8(str), strLength));
  }
}


