import 'package:flutter/material.dart';

class SparklingDot extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final int blinkDuration;

  const SparklingDot({
    Key key,
    this.dotColor = Colors.cyanAccent,
    this.dotSize = 2,
    this.blinkDuration = 500,
  }) : super(key: key);

  @override
  _SparklingDotState createState() => _SparklingDotState();
}

class _SparklingDotState extends State<SparklingDot>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _dispose = false;
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: widget.blinkDuration), () {
      setState(() {_visible = !_visible; });
    });
  }

  bool _dispose = false;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: widget.blinkDuration),
      onEnd: () {
        if (!_dispose) {
          setState(() {
            _visible = !_visible;
          });
        }
      },
      child: Container(
        width: widget.dotSize,
        height: widget.dotSize,
        decoration: BoxDecoration(
          color: widget.dotColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
