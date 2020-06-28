import 'package:bucketlist/screen/component/progress_dot_widget.dart';
import 'package:bucketlist/screen/data/quest_data.dart';
import 'package:flutter/material.dart';

import '../../utilities/constant.dart';
import 'panel_widget.dart';

/// 任務進度總數
const int totalProgressCount = 10;

/// 任務列表項目 面板高度
const double questItemPanelHeight = 90.0 + 24 + 14 + 16;

/// 任務列表項目
class QuestListItem extends StatelessWidget {
  const QuestListItem({
    Key key,
    @required this.panelSize,
    @required this.data,
  }) : super(key: key);

  final Size panelSize;
  final QuestData data;

  @override
  Widget build(BuildContext context) {
    final double iconWidth = 90;
    final dividerWidth = panelSize.width - iconWidth - 50;

    return Center(
      child: PanelWidget(
        panelSize: panelSize,
        title: data.category,
        titleTextSize: 14,
        panelColor: kThemeColor,
        panelTitleColor: Colors.black,
        contentWidget: Row(
          children: [
            Image.asset(
              "images/icCategoryEnv.png",
              width: iconWidth,
              height: iconWidth,
            ),
            SizedBox(width: 12),
            Wrap(
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: panelSize.width - 90 - 24,
                  child: Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kThemeColor, fontSize: 24),
                  ),
                ),
                Container(
                  color: kThemeColor,
                  width: dividerWidth,
                  height: 1,
                  margin: EdgeInsets.only(top: 8, bottom: 4),
                ),
                SizedBox(height: 4),
                Text(
                  'Deadline ${data.deadline}',
                  style: TextStyle(color: kThemeColor),
                ),
                SizedBox(height: 4),
                Wrap(
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(color: kThemeColor),
                    ),
                    ProgressDotBar(
                      nowProgress: data.progressNow,
                      totalProgress: data.progressTotal,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}