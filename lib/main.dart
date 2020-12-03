import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dart_jc666/platform/bridge.dart';
import 'package:flutter_dart_jc666/native/native.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JC666 Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'JC666 Flutter Demo Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = "";
  String responseStream = "";
  int oneNumber = 1000;
  int twoNumber = 1;
  int _counter = 0;
  String str = "JC666";

  //One run One add 1
  void _incrementCounter() {
    setState(() {
      _counter = Native.intAdd(_counter, 1);
    });
  }

  StreamSubscription<String> internetConnectivityStream;

  @override
  void initState() {
    super.initState();
    getMessageFromNative();

    listenToNativeStream();
  }

  @override
  void dispose() {
    internetConnectivityStream?.cancel();
    super.dispose();
  }

  void listenToNativeStream()  {
    internetConnectivityStream = NativeBridge.listenToNativeEventChannel().listen(
            (string) {
          setState(() {
            this.responseStream = string;
          });
        }
    );
  }

  void changeInternetConnectivity() {
    NativeBridge.changeInternetConnectivity();
  }

  // void changeInternetConnectivity() async{
  //   // NativeBridge.changeInternetConnectivity();
  //
  //   String responseFromNative = await NativeBridge.changeInternetConnectivity();
  //   setState(() {
  //     this.responseStream = responseFromNative;
  //   });
  //
  // }

  void getMessageFromNative() async {
    String responseFromNative = await NativeBridge.sayHiToNative();
    setState(() {
      this.response = responseFromNative;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'The message from native platform message channel is',
              textAlign: TextAlign.center,
            ),
            Text(
              '$response',
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
            Text(
              // 'Native index++ : ',
              // textAlign: TextAlign.center,
              //   "native double value = ${doubleAdd(oneNumber.toDouble(), twoNumber.toDouble())}"
                "native reverse str = ${Native.reverseFunc(str, str.length)}"

            ),
            Text(
              // responseStream ? "YES" : "No",
              '$responseStream',
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: changeInternetConnectivity
      ),
    );
  }
}
