import 'package:bucketlist/screen/add_list_screen.dart';
import 'package:bucketlist/screen/bucket_list_screen.dart';
import 'package:bucketlist/screen/signup_screen.dart';
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/test': (context) => TestScreen(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/signUp': (context) => SignUpScreen(),
        '/bucketList': (context) => BucketListScreen(),
        '/addList': (context) => AddListScreen(),
      },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('go to sign up page'),
              onPressed: () {
                Navigator.pushNamed(context, '/signUp');
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
