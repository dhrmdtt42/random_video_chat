import 'package:flutter/material.dart';
import 'package:random_video_app/view_widgets/get_started_home.dart';
import 'package:random_video_app/view_widgets/handler_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HandlerPage(),
    );
  }
}


