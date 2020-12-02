package com.example.flutter_dart_jc666

import android.content.Intent
import android.os.Bundle
import android.util.Log

//import io.flutter.embedding.android.FlutterActivity;
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val TAG = "MainActivity"

    private val CHANNEL = "com.example.flutter_dart_jc666/channel"
    private val METHOD_HELLO = "hello_jc666"
    private val METHOD_CHANGE_INTERNET_CONNECTIVITY = "CHANGE_INTERNET"
    private val METHOD_LONG_ASYNC = "LONG_ASYNC"

    private val EVENT_CHANNEL = "com.example.flutter_dart_jc666/event_channel"

    private var index:Int = 999;

    private var streamHandler: FlutterStreamHandler? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        setUpMethodChannel()
        setUpEventChannel()
    }

    // EVENT CHANNEL SECTION

    private fun setUpEventChannel() {
        val eventChannel = EventChannel(flutterView, EVENT_CHANNEL)
        this.streamHandler = this.streamHandler
                ?: FlutterStreamHandler()
        eventChannel.setStreamHandler(this.streamHandler)
    }

    // METHOD CHANNEL SECTION

    private fun setUpMethodChannel() {
        MethodChannel(flutterView, CHANNEL).setMethodCallHandler {
            methodCall, result ->
            when(methodCall.method) {
                METHOD_HELLO -> hello(methodCall, result)
                METHOD_CHANGE_INTERNET_CONNECTIVITY -> changeInternetConnectivity(methodCall, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun hello(methodCall: MethodCall,
                      result: MethodChannel.Result) {
        result.success("JC666 Native MethodChannel.")
    }

    private fun changeInternetConnectivity(methodCall: MethodCall,
                                           result: MethodChannel.Result) {
        val connectivity = methodCall.argument<Boolean>("connectivity")
        index++

        if (this.streamHandler == null || connectivity == null) return

        val intent = Intent()
//    intent.putExtra("connectivity", connectivity)
        intent.putExtra("connectivity_index",index)
        Log.d(TAG, "Index Count: ${index}")
        this.streamHandler?.handleIntent(this, intent)
    }

//  private fun changeInternetConnectivity(methodCall: MethodCall,
//                                         result: MethodChannel.Result) {
//    index++
//    result.success(index.toString())
//  }

    // TODO: METHOD CALL WITH AWAIT
    private fun veryLongAsyncCall(methodCall: MethodCall,
                                  result: MethodChannel.Result) {

    }

}
