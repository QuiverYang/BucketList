import 'package:flutter/material.dart';

class BucketListScreen extends StatefulWidget {
  BucketListScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BucketListScreenState createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title ?? 'bucket list'}")),
      body: Center(
        child: RaisedButton(
          child: Text('go to add list page'),
          onPressed: () {
            Navigator.pushNamed(context, '/addList');
          },
        ),
      ),
    );
  }
}
