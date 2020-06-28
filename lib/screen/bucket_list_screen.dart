import 'dart:math';

import 'package:bucketlist/utilities/fakedata.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/quest_item_widget.dart';
import 'component/util_widget.dart';
import 'data/quest_data.dart';
import 'detail_screen.dart';

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
    return DragoonScaffold(
      appBar: DragoonAppBar(
        title: "Admin Quest",
        leadingWidget: _leadingButton(),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        child: CustomScrollView(
          slivers: [
            SliverFixedExtentList(
              itemExtent: questItemPanelHeight,
              delegate: SliverChildBuilderDelegate(
                _listItemBuilder,
                childCount: _listItemCount,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 100,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buttomExploreArea();
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttomExploreArea() {
    return Container(
      margin: EdgeInsets.all(24),
      child: FlatButton(
        color: kThemeColor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(
            "Explore Buckets",
            style: Theme.of(context).textTheme.button,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/addList');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: kThemeColor, width: 2),
        ),
      ),
    );
  }

  String _randomCategory() => questTitles1.keys.elementAt(
        Random.secure().nextInt(questTitles1.length),
      );

  String _randomTitle(String category) => questTitles1[category].elementAt(
        Random.secure().nextInt(questTitles1[category].length),
      );

  Widget _listItemBuilder(BuildContext context, int index) {
    final category = _randomCategory();
    final QuestData data = QuestData(
      category: category,
      title: _randomTitle(category),
      iconData: null,
      deadline: "2020/07/24",
      progressTotal: totalProgressCount,
      progressNow: Random.secure().nextInt(totalProgressCount),
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  data: data,
                  templateMode: false,
                )));
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 16),
        child: QuestListItem(
          panelSize: Size(_panelWidth, questItemPanelHeight),
          data: data,
        ),
      ),
    );
  }

  /// todo: return a beautiful icon
  Widget _leadingButton() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.ac_unit),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }
}
