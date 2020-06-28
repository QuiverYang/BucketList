import 'dart:math';

import 'package:bucketlist/screen/data/quest_data.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/panel_widget.dart';
import 'component/util_widget.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key key,
    this.data,
    this.templateMode = true,
  }) : super(key: key);
  final QuestData data;
  final bool templateMode;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  /// 頁面寬度
  double _screenWidth = 0;

  double pagePadding01 = 0;
  double pagePadding005 = 0;

  double areaWidthTitle = 0;
  double areaWidthTimes = 0;
  double areaWidthDurationTitle = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;

    pagePadding01 = _screenWidth * 0.1;
    pagePadding005 = _screenWidth * 0.05;

    final contentWidth = _screenWidth - (pagePadding005 * 3);
    areaWidthTitle = contentWidth * 0.6;
    areaWidthTimes = contentWidth * 0.4;
    areaWidthDurationTitle = contentWidth * 0.3;
  }

  String _digits(String value, String format) {
    String emptyDigits = value.length < format.length
        ? format.substring(0, format.length - value.length)
        : '';
    return "$emptyDigits$value";
  }

  String _datetimeForDisply(DateTime dateTime) {
    final month = _digits("${dateTime.month}", "00");
    final day = _digits("${dateTime.day}", "00");
    final hh = _digits("${dateTime.hour}", "00");
    final mm = _digits("${dateTime.minute}", "00");
    return "${dateTime.year}/$month/$day $hh:$mm";
  }

  String _daytimeFromNow(int days) {
    return _datetimeForDisply(DateTime.now().add(Duration(days: days)));
  }

  @override
  Widget build(BuildContext context) {
    final days = Random.secure().nextInt(100);
    return DragoonScaffold(
      appBar: DragoonAppBar(title: "Plan Detail"),
      body: Container(
        margin: EdgeInsets.only(
          top: 16,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _mainImage(),
                SizedBox(height: pagePadding01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: pagePadding005),
                    Expanded(child: _titleBox(widget.data.title)),
                    _takesTimeBox(days),
                    SizedBox(width: pagePadding005),
                  ],
                ),
                _categoryInfo(),
                SizedBox(height: pagePadding01),
                _timeRow("START TIME", _datetimeForDisply(DateTime.now())),
                SizedBox(height: 8),
                _timeRow("END TIME", _daytimeFromNow(days)),
                SizedBox(height: 8),
                _memoArea(),
                _communityStatus(),
                sizedBoxHeight16,
                _bottomArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleBox(String title) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(
          'PLAN TITLE',
          style: textTheme.subtitle2.apply(color: kThemeColor),
        ),
        Container(
          width: areaWidthTitle,
          child: Text(
            title,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headline5.apply(color: kThemeColor),
          ),
        )
      ],
    );
  }

  Widget _mainImage() {
    final double mainImageHeight = _screenWidth * 0.5;
    return Stack(
      children: [
        Image.asset(
          "images/icCategoryEnv.png",
          width: double.infinity,
          height: mainImageHeight,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: mainImageHeight,
          color: kThemeColor_mask,
        ),
      ],
    );
  }

  Widget _takesTimeBox(int days) {
    final textTheme = Theme.of(context).textTheme;
    final minHeight =
        (textTheme.headline2.fontSize + textTheme.subtitle2.fontSize) * 1.3;

    return Wrap(
      direction: Axis.vertical,
      children: [
        Container(
          color: kThemeColor,
          width: areaWidthTimes,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Text(
            'TAKES TIME',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          margin: EdgeInsets.only(bottom: 4),
        ),
        CustomPaint(
          size: Size(areaWidthTimes, 0),
          painter: TrapezoidPainter(
            panelSize: Size(areaWidthTimes, minHeight),
            strokeWidth: 2,
            panelColor: kThemeColor,
            panelBgColor: Colors.black26,
            sharpWidth: 20,
          ),
          child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: areaWidthTimes,
                child: Text(
                  '$days',
                  textAlign: TextAlign.center,
                  style: textTheme.headline2.apply(color: kThemeColor),
                ),
              ),
              Text(
                'DAYS',
                style: textTheme.subtitle2.apply(color: kThemeColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryInfo() {
    return Row(
      children: [
        SizedBox(width: pagePadding005),
        _categoryTag(),
      ],
    );
  }

  Widget _categoryTag() {
    return Container(
      color: kThemeColor,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      child: Text(
        '${widget.data.category}',
      ),
    );
  }

  Widget _timeRow(String title, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(width: pagePadding005),
        SizedBox(
          width: areaWidthDurationTitle,
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle2.apply(color: kThemeColor),
          ),
        ),
        SizedBox(width: pagePadding005 / 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.headline6.apply(color: kThemeColor),
        ),
      ],
    );
  }

  Widget _memoArea() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: pagePadding005, vertical: pagePadding005),
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Wrap(
            children: [
              Text(
                "MEMO",
                style: textTheme.subtitle2.apply(color: kThemeColor),
              ),
              Text(
                " (only you can see)",
                style:
                    textTheme.subtitle2.apply(color: kThemeColor_transparent),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: _screenWidth - pagePadding01,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kThemeColor_transparent,
            ),
            child: TextField(
              maxLines: 3,
              style: TextStyle(fontSize: 16, color: kThemeColor),
              cursorColor: kThemeColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomArea() {
    if (widget.templateMode) {
      final textTheme = Theme.of(context).textTheme;
      return Container(
        margin: EdgeInsets.only(
            left: pagePadding005, right: pagePadding005, bottom: pagePadding01),
        child: FlatButton(
          color: kThemeColor,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(
              "Let's Do This!",
              style: textTheme.button,
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
      );
    } else {
      return SizedBox(
        height: pagePadding01,
      );
    }
  }

  Widget _communityStatus() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${Random.secure().nextInt(50)} PEOPLE DOING THIS PLAN.\n"
          " ${Random.secure().nextInt(100)} PEOPLE DONE.",
          style: textTheme.subtitle2.apply(
            color: kThemeColor_transparent,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
