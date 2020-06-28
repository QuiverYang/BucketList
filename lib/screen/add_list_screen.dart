import 'dart:math';

import 'package:bucketlist/screen/data/quest_data.dart';
import 'package:bucketlist/utilities/fakedata.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/quest_item_widget.dart';
import 'component/util_widget.dart';
import 'detail_screen.dart';

class AddListScreen extends StatefulWidget {
  AddListScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen>
    with TickerProviderStateMixin {
  /// 任務面板寬度
  double _panelWidth = 0;
  int _nowCategory = 0;
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: _nowCategory,
    );
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _panelWidth = MediaQuery.of(context).size.width - 48;
    _changeCategory(0);
  }

  _changeCategory(int index) {
    _nowCategory = index;
  }

  @override
  Widget build(BuildContext context) {
    return DragoonScaffold(
      appBar: DragoonAppBar(
        title: kExplorePageTitle,
        bottom: TabBar(
          isScrollable: true,
          tabs: categories.map(_categoryTab).toList(),
          controller: _tabController,
          indicatorColor: kThemeColor,
          labelColor: kThemeColor,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
        child: PageView.builder(
          controller: _pageController,
          itemCount: _tabController.length,
          itemBuilder: _categoryListPageBuilder,
          onPageChanged: (index) {
            _tabController.index = index;
          },
        ),
      ),
    );
  }

  Widget _categoryTab(String text) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 0, bottom: 16),
      child: Text(text),
    );
  }

  Widget _categoryListPageBuilder(BuildContext context, int pageIndex) {
    final category = questTitles1.keys.elementAt(pageIndex);
    return ListView.separated(
      itemCount: questTitles1[category].length,
      separatorBuilder: (BuildContext context, int index) => sizedBoxHeight16,
      itemBuilder: (BuildContext context, int index) {
        return _categoryListItemBuilder(category, index);
      },
    );
  }

  Widget _categoryListItemBuilder(String category, int index) {
    final data = QuestData(
      category: category,
      title: questTitles1[category].elementAt(index),
      iconData: null,
      deadline: kDefaultDate,
      progressTotal: totalProgressCount,
      progressNow: Random.secure().nextInt(totalProgressCount),
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  data: data,
                  templateMode: true,
                )));
      },
      child: QuestListItem(
        panelSize: Size(_panelWidth, questItemPanelHeight),
        data: data,
      ),
    );
  }
}
