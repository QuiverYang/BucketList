import 'dart:math';

import 'package:bucketlist/utilities/fakedata.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/panel_widget.dart';
import 'component/progress_dot_widget.dart';
import 'component/util_widget.dart';

class BucketListScreen extends StatefulWidget {
  BucketListScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BucketListScreenState createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  /// 任務數量
  int _listItemCount = Random.secure().nextInt(6) + 1;

  /// 任務面板寬度
  double _panelWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _panelWidth = MediaQuery.of(context).size.width - 48;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DragoonAppBar(
        title: "Admin Quest",
        leadingWidget: _leadingButton(),
      ),
      backgroundColor: Colors.black,
      drawer: _drawer(),
      floatingActionButton: _fab(),
      body: Stack(
        children: [
          DragoonAppBg(),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.separated(
              itemCount: _listItemCount,
              separatorBuilder: _listSeperator,
              itemBuilder: _listItemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listSeperator(BuildContext context, int index) {
    return SizedBox(
      height: 16,
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    Size panelSize = Size(_panelWidth, 90.0 + 24 + 14);
    final totalProgressCount = 10;
    final double iconWidth = 90;
    final dividerWidth = panelSize.width - iconWidth - 50;

    final category = questTitles1.keys.elementAt(Random.secure().nextInt(questTitles1.length));
    final title = questTitles1[category].elementAt(Random.secure().nextInt(questTitles1[category].length));

    return Center(
      child: PanelWidget(
        panelSize: panelSize,
        title: category,
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
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kThemeColor, fontSize: 24),
                ),
                Container(
                  color: kThemeColor,
                  width: dividerWidth,
                  height: 1,
                  margin: EdgeInsets.only(top: 8, bottom: 4),
                ),
                SizedBox(height: 4),
                Text(
                  'Deadline 2020/07/24',
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
                      nowProgress: Random.secure().nextInt(totalProgressCount),
                      totalProgress: totalProgressCount,
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

  Widget _leadingButton() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/addList');
      },
      child: Icon(Icons.add),
      backgroundColor: kThemeColor,
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }
}
