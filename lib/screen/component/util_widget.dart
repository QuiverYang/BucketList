import 'package:flutter/material.dart';

import '../../utilities/constant.dart';
import 'sparkling_mask_widget.dart';

const Widget sizedBoxHeight16 = const SizedBox(height: 16);

const Widget sizedBoxWidth8 = const SizedBox(width: 8);

class DragoonAppBar extends AppBar {
  DragoonAppBar({
    Key key,
    String title,
    Widget leadingWidget,
    Widget bottom,
  }) : super(
          key: key,
          iconTheme: IconThemeData(
            color: kThemeColor, //change your color here
          ),
          title: Text(
            title,
            style: TextStyle(color: kThemeColor),
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(160, 22, 29, 32),
          leading: leadingWidget,
          bottom: bottom,
          centerTitle: true,
        );
}

class DragoonScaffold extends Scaffold {
  DragoonScaffold({
    Key key,
    AppBar appBar,
    Color backgroundColor = Colors.black,
    Widget body,
  }) : super(
          key: key,
          extendBodyBehindAppBar: true,
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              DragoonAppBg(),
              SafeArea(
                child: body,
              )
            ],
          ),
        );
}

class DragoonAppBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/appBg@3x.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        SparklingMask(
          size: MediaQuery.of(context).size,
        ),
      ],
    );
  }
}

class MainButtonStroked extends FlatButton {
  MainButtonStroked({
    Key key,
    String text,
    VoidCallback onPressed,
  }) : super(
          key: key,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: kThemeColor, fontSize: 20),
            ),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: kThemeColor,
              width: 2,
            ),
          ),
        );
}

class MainButtonFilled extends FlatButton {
  MainButtonFilled({
    Key key,
    String text,
    VoidCallback onPressed,
  }) : super(
    key: key,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: kTextColor, fontSize: 20),
      ),
    ),
    onPressed: onPressed,
    color: kThemeColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(
        color: kThemeColor,
        width: 2,
      ),
    ),
  );
}


