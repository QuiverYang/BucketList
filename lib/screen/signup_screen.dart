import 'package:bucketlist/utilities/constant.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kThemeColor, //change your color here
          ),
          title: Text(
            "${widget.title ?? 'Sign up'}",
            style: TextStyle(color: kThemeColor),
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(160, 22, 29, 32),
        ),
        body: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/appBg@3x.png"),
                fit: BoxFit.cover,
              ),
              color: Color.fromARGB(255, 117, 53, 83),
            ),
//        constraints: BoxConstraints.expand(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Admin Quests',
                    style: TextStyle(color: kThemeColor, fontSize: 40),
                  ),
                  FlatButton(
                    color: kThemeColor,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Done',
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
                ],
              ),
            ),
          ), // This trailin,
        ));
  }
}
