import 'package:bucketlist/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'component/panel_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final panelWidth = MediaQuery.of(context).size.width - 48;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PanelWidget(
                  panelSize: Size(panelWidth, panelWidth * 0.85),
                  title: "Profile",
                  titleTextSize: 14,
                  contentWidget: Column(
                    children: [
                      oneRow('Name', 'Dragoon dot TW', panelWidth: panelWidth),
                      oneRow('Birthday', '1987/11/11', panelWidth: panelWidth),
                      oneRow('Location', 'Taiwan', panelWidth: panelWidth),
                      oneRow('Gender', 'Male', panelWidth: panelWidth),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                PanelWidget(
                  panelSize: Size(panelWidth, panelWidth * 0.5),
                  title: "Life",
                  titleTextSize: 14,
                  contentWidget: Container(
                    width: panelWidth - width * 0.2 + 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '剩餘壽命',
                          style: TextStyle(color: Colors.white),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '30', style: TextStyle(fontSize: 90)),
                            TextSpan(text: '/80')
                          ]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '地區平均壽命',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
      ),
    );
  }

  Widget oneRow(String title, String hint, {double panelWidth}) {
    return Container(
      constraints: BoxConstraints(maxWidth: panelWidth),
      padding: EdgeInsets.only(right: 70, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: kThemeColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(100, 147, 218, 216),
                hintText: hint,
                hintStyle: TextStyle(color: kThemeColor, fontSize: 18),
              ),
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }
}
