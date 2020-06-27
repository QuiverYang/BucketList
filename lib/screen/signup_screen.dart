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
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title ?? 'sign up'}")),
      body: Center(
        child: RaisedButton(
          child: Text('go to bucket list page'),
          onPressed: () {
            Navigator.pushNamed(context, '/bucketList');
          },
        ),
      ),
    );
  }
}
