import 'dart:math';

import 'package:bucketlist/utilities/fakedata.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/quest_item_widget.dart';
import 'component/util_widget.dart';
import 'data/quest_data.dart';

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

  Widget _listSeperator(BuildContext context, int index) => sizedBoxHeight16;

  String _randomCategory() => questTitles1.keys.elementAt(
        Random.secure().nextInt(questTitles1.length),
      );

  String _randomTitle(String category) => questTitles1[category].elementAt(
        Random.secure().nextInt(questTitles1[category].length),
      );

  Widget _listItemBuilder(BuildContext context, int index) {
    final category = _randomCategory();
    return QuestListItem(
      panelSize: Size(_panelWidth, questItemPanelHeight),
      data: QuestData(
        category: category,
        title: _randomTitle(category),
        iconData: null,
        deadline: "2020/07/24",
        progressTotal: totalProgressCount,
        progressNow: Random.secure().nextInt(totalProgressCount),
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
