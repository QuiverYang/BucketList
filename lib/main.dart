import 'package:bucketlist/screen/add_list_screen.dart';
import 'package:bucketlist/screen/bucket_list_screen.dart';
import 'package:bucketlist/screen/signup_screen.dart';
import 'package:bucketlist/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'screen/test_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Wallpoet',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      routes: {
        '/test': (context) => TestScreen(),
        '/': (context) => LoginScreen(title: 'Flutter Demo Home Page'),
        '/signUp': (context) => SignUpScreen(),
        '/bucketList': (context) => BucketListScreen(),
        '/addList': (context) => AddListScreen(),
      },
    );
  }
}
