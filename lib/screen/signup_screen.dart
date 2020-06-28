import 'package:bucketlist/utilities/constant.dart';
import 'package:bucketlist/utilities/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'component/panel_widget.dart';
import 'component/util_widget.dart';
import 'package:bucketlist/utilities/fakedata.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController locationTEC;
  TextEditingController birthdayTEC;
  TextEditingController genderTEC;
  TextEditingController nameTEC;

  @override
  void initState() {
    super.initState();
    locationTEC = TextEditingController();
    birthdayTEC = TextEditingController();
    genderTEC = TextEditingController();
    nameTEC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final panelWidth = MediaQuery.of(context).size.width - 48;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DragoonAppBar(
        title: 'Sign up',
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
                  title: "PROFILE",
                  titleTextSize: 14,
                  contentWidget: Column(
                    children: [
                      oneRow('NAME', 'Dragoon dot TW',
                          panelWidth: panelWidth,
                          textEditingController: nameTEC),
                      oneRow('BIRTHDAY', '1987/11/11',
                          panelWidth: panelWidth,
                          textEditingController: birthdayTEC),
                      oneRow('LOCATION', 'Taiwan',
                          panelWidth: panelWidth,
                          pickData: avgLife,
                          textEditingController: locationTEC),
                      oneRow('GENDER', 'Male',
                          panelWidth: panelWidth,
                          pickData: {'Male': 0, 'Female': 0},
                          loop: false,
                          textEditingController: genderTEC),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                PanelWidget(
                  panelSize: Size(panelWidth, panelWidth * 0.5),
                  title: "EXPECTANCY",
                  titleTextSize: 14,
                  contentWidget: Container(
                    width: panelWidth - width * 0.2 + 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${nameTEC.text}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: MyStatefulWidget(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: _countAge(birthdayTEC.text) ?? '0',
                                    style: TextStyle(fontSize: 90)),
                                TextSpan(
                                    text:
                                        '/${avgLife["${locationTEC.text == '' ? 'Taiwan' : locationTEC.text}"]}')
                              ]),
                            ),
                          ),
                        ),
                        Text(
                          '${locationTEC.text} life Exp',
                          style: TextStyle(color: Colors.white),
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
                    Navigator.of(context).pushNamed('/bucketList');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: kThemeColor, width: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 生日只能是yyyy/mm/dd or yyyymmdd
  String _countAge(String birthdayStr) {
    String result;
    if (birthdayStr == null || birthdayStr == '') return result;
    var now = DateTime.now();
    var formatedBirth = birthdayStr.replaceAll('/', '');
    try {
      var birthday = DateTime.parse(formatedBirth);
      var age = now.year - birthday.year;
      return '$age';
    } catch (e) {
      print('birthday parse error $e');
      return result;
    }
  }

  Widget oneRow(String title, String hint,
      {double panelWidth,
      Map<String, dynamic> pickData,
      bool loop = true,
      TextEditingController textEditingController}) {
    TextEditingController _textEditingController =
        textEditingController ?? TextEditingController();

    double _textFieldWidth = 150;
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
            width: _textFieldWidth,
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(100, 147, 218, 216),
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                labelStyle: TextStyle(color: kThemeColor, fontSize: 14),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  _textEditingController.text = value;
                });
              },
              style: TextStyle(color: kThemeColor, fontSize: 18),
              onTap: () async {
                String selected = await showDragoonCupertinoPicker(
                    context, pickData,
                    title: title, loop: loop);
                if (selected != null && selected != '') {
                  _textEditingController.text = selected;
                  setState(() {});
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.child}) : super(key: key);
  final child;
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Widget contentWidget;
  @override
  void initState() {
    super.initState();
    contentWidget = widget.child ?? Text('sample');
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: contentWidget,
    );
  }
}
