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

  double width = 0;
  double height = 0;
  double panelWidth = 0;
  double pagePadding01 = 0;
  double pagePadding005 = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    panelWidth = MediaQuery.of(context).size.width - 48;
    pagePadding01 = width * 0.1;
    pagePadding005 = width * 0.05;
  }

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
    return DragoonScaffold(
      appBar: DragoonAppBar(
        title: 'Sign up',
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pagePadding01, vertical: pagePadding005),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _profileArea(),
                SizedBox(height: 20),
                _expectancyArea(
                  areaLabel: '${locationTEC.text} life Exp',
                ),
                SizedBox(height: 20),
                _footerArea(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton _footerArea(BuildContext context) {
    return FlatButton(
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
    );
  }

  PanelWidget _expectancyArea({
    String areaLabel,
  }) {
    final areaWidth = panelWidth - width * 0.2 + 16;
    return PanelWidget(
      panelSize: Size(panelWidth, panelWidth * 0.5),
      title: "EXPECTANCY",
      titleTextSize: 14,
      contentWidget: Container(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: areaWidth,
              child: Text(
                '${nameTEC.text}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    MyStatefulWidget(
                      key: UniqueKey(),
                      child: RichText(
                        text: TextSpan(
                            text: _countAge(birthdayTEC.text) ?? '0',
                            style: TextStyle(fontSize: 90)),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      '/${avgLife["${locationTEC.text == '' ? 'Taiwan' : locationTEC.text}"]}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: areaWidth,
              child: Text(
                areaLabel,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PanelWidget _profileArea() {
    return PanelWidget(
      panelSize: Size(panelWidth, panelWidth * 0.85),
      title: "PROFILE",
      titleTextSize: 14,
      contentWidget: Column(
        children: [
          oneRow(
            'NAME',
            'Dragoon dot TW',
            panelWidth: panelWidth,
            textEditingController: nameTEC,
          ),
          oneRow(
            'BIRTHDAY',
            '1987/11/11',
            panelWidth: panelWidth,
            textEditingController: birthdayTEC,
          ),
          oneRow(
            'LOCATION',
            'Taiwan',
            panelWidth: panelWidth,
            pickData: avgLife,
            textEditingController: locationTEC,
          ),
          oneRow(
            'GENDER',
            'Male',
            panelWidth: panelWidth,
            pickData: {'Male': 0, 'Female': 0},
            loop: false,
            textEditingController: genderTEC,
          ),
        ],
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

  Widget oneRow(
    String title,
    String hint, {
    double panelWidth,
    Map<String, dynamic> pickData,
    bool loop = true,
    TextEditingController textEditingController,
    ValueChanged<String> onChange,
  }) {
    TextEditingController _textEditingController =
        textEditingController ?? TextEditingController();

    double _textFieldWidth = panelWidth * 0.5;

    final textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(maxWidth: panelWidth),
      padding: EdgeInsets.only(right: 70, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.subtitle2.apply(
              color: kThemeColor,
            ),
          ),
          Container(
            width: _textFieldWidth,
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: kThemeColor_transparent,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                labelStyle: TextStyle(color: kThemeColor, fontSize: 14),
              ),
              textAlign: TextAlign.center,
              onChanged: onChange,
              style: textTheme.subtitle2.apply(
                color: kThemeColor,
              ),
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
      begin: Offset(0, -0.5),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: contentWidget,
    );
  }
}
