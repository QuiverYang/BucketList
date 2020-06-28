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
  Color colorStart = Colors.red;
  Color colorEnd = Colors.deepPurple;
  Color _newColor;
  @override
  void initState() {
    super.initState();
    _newColor = colorEnd;
  }

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
                  child: Image.asset('images/earthSlow.gif'),
                  tween: ColorTween(begin: colorStart, end: _newColor),
                  duration: Duration(seconds: 1),
                  onEnd: () {
                    setState(() {
                      math.Random().nextInt(255);
                      colorEnd = Color.fromARGB(
                          math.Random().nextInt(255),
                          math.Random().nextInt(255),
                          math.Random().nextInt(255),
                          math.Random().nextInt(255));
                      _newColor = colorEnd;
                    });
                  },
                  builder: (_, Color color, myChild) {
                    return ColorFiltered(
                      child: myChild,
                      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/bucketList');
                },
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
