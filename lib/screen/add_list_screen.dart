import 'dart:math';

import 'package:bucketlist/screen/data/quest_data.dart';
import 'package:bucketlist/utilities/fakedata.dart';
import 'package:flutter/material.dart';

import 'component/quest_item_widget.dart';
import 'component/util_widget.dart';

class AddListScreen extends StatefulWidget {
  AddListScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  /// 任務面板寬度
  double _panelWidth = 0;
  int _nowCategory = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _panelWidth = MediaQuery.of(context).size.width - 48;
    _changeCategory(0);
  }

  int _categoryItemCount = 0;
  String _category;

  _changeCategory(int index) {
    _nowCategory = index;
    _category = questTitles1.keys.elementAt(_nowCategory);
    _categoryItemCount = questTitles1[_category].length;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_categoryItemCount=$_categoryItemCount");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DragoonAppBar(
        title: "Templates",
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          DragoonAppBg(),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.separated(
              itemCount: _categoryItemCount,
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
    return QuestListItem(
      panelSize: Size(_panelWidth, questItemPanelHeight),
      data: QuestData(
        category: _category,
        title: questTitles1[_category].elementAt(index),
        iconData: null,
        deadline: "---- / -- / --",
        progressTotal: totalProgressCount,
        progressNow: Random.secure().nextInt(totalProgressCount),
      ),
    );
  }
}
