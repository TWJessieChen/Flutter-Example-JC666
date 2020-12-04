import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dart_jc666/home.dart';
import 'package:uni_links/uni_links.dart';

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
        home: StreamBuilder(
          stream: getLinksStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) { // our app started by configured links
              var uri = Uri.parse(snapshot.data);
              var list = uri.queryParametersAll.entries
                  .toList(); // we retrieve all query parameters , tzd://genius-team.com?product_id=1

              return Text(list.map((f) => f.toString()).join('-'));
              // we just print all //parameters but you can now do whatever you want, for example open //product details page.
            } else {
              // our app started normally
              return MyHomePage(title: 'JC666 Flutter Demo Example');
            }
          },
        )
      // home: MyHomePage(title: 'JC666 Flutter Demo Example'),
    );
  }
}



