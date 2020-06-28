import 'dart:math';

import '../../screen/component/sparkaling_dot_widget.dart';
import '../../utilities/constant.dart';
import 'package:flutter/material.dart';

class SparklingMask extends StatefulWidget {
  final Size size;

  SparklingMask({@required this.size});

  @override
  _SparklingMaskState createState() => _SparklingMaskState();
}

class _SparklingMaskState extends State<SparklingMask> {
  double _screenWidth = 0;
  double _screenHeight = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = widget.size.width;
    _screenHeight = widget.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sparklingChildren = [];

    /// average small dot
    sparklingChildren.addAll(_dotList(
      count: 30,
      yOffset: 0,
      sizeBase: 10,
      durationMillisOffset: 500,
    ));

    /// top medium dot
    sparklingChildren.addAll(_dotList(
      count: 10,
      yRatio: 0.1,
      sizeBase: 50,
      durationMillisOffset: 1000,
    ));

    /// bottom medium dot
    sparklingChildren.addAll(_dotList(
      count: 10,
      yOffset: _screenHeight * 0.6,
      sizeBase: 40,
      durationMillisOffset: 1000,
    ));

    /// bottom large dot
    sparklingChildren.addAll(_dotList(
      count: 10,
      yOffset: _screenHeight * 0.8,
      sizeBase: 60,
      durationMillisOffset: 2000,
    ));

    /// bottom super large dot
    sparklingChildren.addAll(_dotList(
      count: 5,
      yOffset: _screenHeight * 0.8,
      sizeBase: 100,
      durationMillisOffset: 2000,
    ));

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      child: Stack(
        children: sparklingChildren,
      ),
    );
  }

  Color _randomColor() => kSparkaling.elementAt(
        Random.secure().nextInt(kSparkaling.length),
      );

  int _randomAlpha() => 50 + Random.secure().nextInt(200);

  double _randomDouble() => Random.secure().nextDouble();

  double _randomDotSize({int base = 10}) => _randomDouble() * base;

  double _randomX() => _randomDouble() * _screenWidth;

  double _randomY({double offset = 0}) =>
      offset + _randomDouble() * (_screenHeight - offset);

  int _randomDuration({int offset = 500}) =>
      (_randomDouble() * 1000).toInt() + offset;

  List<Widget> _dotList({
    int count,
    double yOffset = 0,
    double yRatio = 1,
    int sizeBase,
    int durationMillisOffset,
  }) =>
      List.generate(
        count,
        (index) => Positioned(
          left: _randomX(),
          top: _randomY(offset: yOffset) * yRatio,
          child: SparklingDot(
            dotColor: _randomColor().withAlpha(_randomAlpha()),
            dotSize: _randomDotSize(base: sizeBase),
            blinkDuration: _randomDuration(offset: durationMillisOffset),
          ),
        ),
      );
}
