import 'package:flutter/material.dart';

import '../../utilities/constant.dart';

class ProgressDotBar extends StatelessWidget {
  final int nowProgress;
  final int totalProgress;

  const ProgressDotBar({Key key, this.nowProgress, this.totalProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _progressDotBar(nowProgress, totalProgress);
  }

  Widget _progressDotBar(int now, int total) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Wrap(
        children: List.generate(total, (index) => _progressDot(index < now)),
      ),
    );
  }

  Widget _progressDot(bool fill) {
    return fill
        ? Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.all(2),
            color: kThemeColor,
          )
        : Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(
              color: kThemeColor,
              width: 1,
            )),
          );
  }
}
