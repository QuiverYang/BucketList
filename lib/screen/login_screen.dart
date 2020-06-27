import 'package:bucketlist/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/appBg@3x.png"),
            fit: BoxFit.cover,
          ),
          color: Color.fromARGB(255, 117, 53, 83),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Admin Quests',
                style: TextStyle(color: kThemeColor, fontSize: 40),
              ),
              SizedBox(height: height * 0.12),
              TweenAnimationBuilder(
                  duration: Duration(seconds: 3),
                  tween: Tween<double>(begin: 0, end: 2 * math.pi),
                  builder: (_, double angle, __) {
                    return Transform.rotate(
                      angle: angle,
                      child: Image.asset(
                        'images/earth@3x.png',
                        width: width * 0.7,
                      ),
                    );
                  }),
              SizedBox(height: height * 0.06),
              FlatButton(
                color: kThemeColor,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: kTextColor, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: kThemeColor, width: 2),
                ),
              ),
              SizedBox(height: 5),
              FlatButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(color: kThemeColor, fontSize: 20),
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: kThemeColor, width: 2),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: Text(
                  'Forgot Account??',
                  style: TextStyle(color: kThemeColor),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
