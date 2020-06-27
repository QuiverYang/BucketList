import 'package:flutter/material.dart';

class AddListScreen extends StatefulWidget {
  AddListScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title ?? 'add list'}")),
      body: Center(
        child: RaisedButton(
          child: Text('go back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
