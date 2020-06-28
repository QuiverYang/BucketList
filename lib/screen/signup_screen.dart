import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bucket_list_screen.dart';
import 'component/panel_widget.dart';
import 'component/util_widget.dart';

import '../utilities/page_route.dart';
import '../utilities/constant.dart';
import '../utilities/fakedata.dart';
import '../utilities/methods.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
//  TextEditingController locationTEC;
//  TextEditingController birthdayTEC;
//  TextEditingController genderTEC;
  TextEditingController nameTEC;

  double width = 0;
  double height = 0;
  double panelWidth = 0;
  double pagePadding01 = 0;
  double pagePadding005 = 0;
  double profileLabelWidth = 0;
  double profileValueWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    panelWidth = MediaQuery.of(context).size.width - 48;
    pagePadding01 = width * 0.1;
    pagePadding005 = width * 0.05;
    profileLabelWidth = (panelWidth - (pagePadding005 * 3)) * 0.38;
    profileValueWidth = (panelWidth - (pagePadding005 * 3)) * 0.58;
  }

  @override
  void initState() {
    super.initState();
    nameTEC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DragoonScaffold(
      appBar: DragoonAppBar(
        title: kSignupPageTitle,
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
                  areaLabel: '${_selectedLocation ?? ""} $kLifeExp',
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
    return MainButtonFilled(
      text: kDone,
      onPressed: () {
        Navigator.pushReplacement(
          context,
          FadeRoute(
            routeName: kRouteBucketListPage,
            page: BucketListScreen(),
          ),
        );
      },
    );
  }

  PanelWidget _expectancyArea({
    String areaLabel,
  }) {
    final areaWidth = panelWidth - width * 0.2 + 16;

    final int remainYears = _countRemainYears(_selectedBirthday);
    debugPrint("remainYears=$remainYears");
    return PanelWidget(
      panelSize: Size(panelWidth, panelWidth * 0.5),
      title: kExpectancy,
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
            CountWidget(
              targetNumber: remainYears,
              fromNumber: 0,
            ),
            SizedBox(
              width: areaWidth,
              child: Text(
                '/ ${avgLife["${_selectedLocation ?? kDefaultArea}"]}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
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

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1987),
        firstDate: DateTime(1911, 8),
        lastDate: DateTime(2020));
    _selectedBirthday = "${picked.year}/${picked.month}/${picked.day}";
    setState(() {});
  }

  String _selectedBirthday;

  String _selectedLocation;

  String _selectedGender;

  Widget _profileAreaLabel(String title) {
    return SizedBox(
      width: profileLabelWidth,
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2.apply(
              color: kThemeColor,
            ),
      ),
    );
  }

  final double valueHeight = 36;
  final double valueInputHeight = 48;
  final double valueVerticalPadding = 12;

  Widget _profileArea() {
    final textTheme = Theme.of(context).textTheme;
    final areaHeight = pagePadding01 * 2 +
        ((valueVerticalPadding + valueHeight) * 3) +
        valueInputHeight;
    return Stack(
      children: [
        PanelWidget(
          panelSize: Size(panelWidth, areaHeight),
          title: kProfile,
          titleTextSize: 14,
          contentWidget: SizedBox(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: pagePadding01,
          ),
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              spacing: valueVerticalPadding,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _profileAreaLabel(kName),
                    Container(
                      width: profileValueWidth,
                      decoration: BoxDecoration(
                        color: kThemeColor_transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: TextField(
                        controller: nameTEC,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                          border: InputBorder.none,
                          hintText: kNameHint,
                          hintStyle: TextStyle(color: kTextColor, fontSize: 14),
                          labelStyle:
                              TextStyle(color: kThemeColor, fontSize: 14),
                        ),
                        textAlign: TextAlign.center,
                        style: textTheme.subtitle2.apply(
                          color: kThemeColor,
                        ),
                      ),
                    )
                  ],
                ),
                // birthday
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _profileAreaLabel(kBirthday),
                    _profileValueButton(
                      onTap: () => _selectDate(context),
                      displayText: _selectedBirthday,
                      hint: kBirthdayHint,
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _profileAreaLabel(kLocation),
                    _profileValueButton(
                      onTap: _pickLocation,
                      displayText: _selectedLocation,
                      hint: kLocationHint,
                    ),
                  ],
                ),

                // gender
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _profileAreaLabel(kGender),
                    _profileValueButton(
                      onTap: _pickGender,
                      displayText: _selectedGender,
                      hint: kGenderHint,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileValueButton(
      {VoidCallback onTap, String displayText, String hint}) {
    TextStyle textStyle = Theme.of(context)
        .textTheme
        .subtitle2
        .apply(color: displayText == null ? kTextColor : kThemeColor);

    return SizedBox(
      width: profileValueWidth,
      height: valueHeight,
      child: FlatButton(
          color: kThemeColor_transparent,
          onPressed: onTap,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            displayText ?? hint,
            style: textStyle,
          )),
    );
  }

  _pickLocation() async {
    String selected = await showDragoonCupertinoPicker(
      context,
      avgLife,
      title: kLocation,
      loop: true,
    );
    if (selected != null && selected != '') {
      _selectedLocation = selected;
      setState(() {});
    }
  }

  _pickGender() async {
    String selected = await showDragoonCupertinoPicker(
      context,
      {kGenderMale: 0, kGenderFemale: 0},
      title: kLocation,
      loop: false,
    );
    if (selected != null && selected != '') {
      _selectedGender = selected;
      setState(() {});
    }
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

  int _countRemainYears(String birthdayStr) {
    if (birthdayStr == null || birthdayStr == '') return 0;
    try {
      final birthYear = int.parse(birthdayStr.split("/")[0]);
      return DateTime.now().year - birthYear;
    } catch (e) {
      print('birthday parse error $e');
    }
    return 0;
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

class CountWidget extends StatefulWidget {
  final int targetNumber;
  final int fromNumber;

  const CountWidget({Key key, this.targetNumber, this.fromNumber})
      : super(key: key);

  @override
  _CountWidgetState createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  int _frameCount = 0;
  bool _disposed = true;
  int _nowFrame = 0;
  int durationMillis = 100;
  String _displayText = "";
  int _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _disposed = false;
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  _reset() {
    _totalAmount = widget.targetNumber - widget.fromNumber;
    _frameCount = _totalAmount > 20 ? 20 : _totalAmount;
    _nowFrame = 0;
    _displayText = "${widget.fromNumber}";
  }


  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _reset();
  }

  @override
  Widget build(BuildContext context) {
    if (_nowFrame < _frameCount) {
      Future.delayed(Duration(milliseconds: durationMillis), () {
        if (_disposed) {
          return;
        }
        _nowFrame++;
        if (_nowFrame == _frameCount) {
          // final frame
          _displayText = "${widget.targetNumber}";
        } else {
          _displayText = "${((_totalAmount / _frameCount) * _nowFrame).toInt()}";
        }
        setState(() {});
      });
    }
    return Container(
      child: Text(
        _displayText,
        style: Theme.of(context).textTheme.headline2.apply(
              color: kThemeColor,
            ),
      ),
    );
  }
}
