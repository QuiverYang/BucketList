import 'package:flutter/material.dart';
import 'screen/add_list_screen.dart';
import 'screen/bucket_list_screen.dart';
import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';
import 'screen/test_screen.dart';
import 'utilities/constant.dart';

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
        fontFamily: kMainFont,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      routes: {
        '/test': (context) => TestScreen(),
        kRouteDefault: (context) => LoginScreen(title: 'Flutter Demo Home Page'),
        kRouteSignupPage: (context) => SignUpScreen(),
        kRouteBucketListPage: (context) => BucketListScreen(),
        kRouteAddListPage: (context) => AddListScreen(),
      },
    );
  }
}
