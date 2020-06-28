import 'dart:math';

import 'package:flutter/material.dart';

class LoginMainImage extends StatefulWidget {
  @override
  _LoginMainImageState createState() => _LoginMainImageState();
}

class _LoginMainImageState extends State<LoginMainImage> {
  Color colorStart = Colors.red;
  Color colorEnd = Colors.deepPurple;
  Color _newColor;

  @override
  void initState() {
    super.initState();
    _newColor = colorEnd;
  }

  int _randomInt(int range) => Random.secure().nextInt(range);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS) {
      return TweenAnimationBuilder(
          child: Image.asset('images/earthSlow.gif'),
          tween: ColorTween(begin: colorStart, end: _newColor),
          duration: Duration(seconds: 1),
          onEnd: () {
            setState(() {
              _randomInt(255);
              colorEnd = Color.fromARGB(
                  200 + _randomInt(55),
                  200 + _randomInt(55),
                  100 + _randomInt(50),
                  200 + _randomInt(55));
              _newColor = colorEnd;
            });
          },
          builder: (_, Color color, myChild) {
            return ColorFiltered(
              child: myChild,
              colorFilter: ColorFilter.mode(color, BlendMode.modulate),
            );
          });
    } else {
      return SizedBox(width: 0,);
    }

  }
}
