import 'package:bucketlist/screen/data/quest_data.dart';
import 'package:flutter/material.dart';

import '../utilities/constant.dart';
import 'component/panel_widget.dart';
import 'component/progress_dot_widget.dart';
import 'component/util_widget.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.data}) : super(key: key);
  final QuestData data;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  /// 任務面板寬度
  double _panelWidth = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _panelWidth = MediaQuery.of(context).size.width - 48;
  }

  String _category;

  @override
  Widget build(BuildContext context) {
    final double iconWidth = 90;
    final dividerWidth = _panelWidth - iconWidth - 50;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DragoonAppBar(title: "Detail Page"),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          DragoonAppBg(),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: PanelWidget(
                      panelSize: Size(_panelWidth, 300),
                      title: widget.data.category,
                      titleTextSize: 14,
                      panelColor: kThemeColor,
                      panelTitleColor: Colors.black,
                      contentWidget: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Row(
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
                                    widget.data.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: kThemeColor, fontSize: 24),
                                  ),
                                  Container(
                                    color: kThemeColor,
                                    width: dividerWidth,
                                    height: 1,
                                    margin: EdgeInsets.only(top: 8, bottom: 4),
                                  ),
                                  SizedBox(height: 4),
                                  Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: kThemeColor,
                                        ),
                                        sizedBoxWidth8,
                                        Text(
                                          'now ~ ${widget.data.deadline}',
                                          style: TextStyle(color: kThemeColor),
                                        ),
                                      ]),
                                  SizedBox(height: 4),
                                  Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          color: kThemeColor,
                                        ),
                                        sizedBoxWidth8,
                                        ProgressDotBar(
                                          nowProgress: widget.data.progressNow,
                                          totalProgress:
                                              widget.data.progressTotal,
                                        ),
                                      ]),
                                ],
                              ),
                            ],
                          ),
                          sizedBoxHeight16,
                          Text(
                            'Memo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kThemeColor, fontSize: 16),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            width: _panelWidth - 40,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kThemeColor_transparent,
                            ),
                            child: TextField(
                              maxLines: 3,
                              style:
                                  TextStyle(fontSize: 16, color: kThemeColor),
                              cursorColor: kThemeColor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight16,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: FlatButton(
                      color: kThemeColor,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: kTextColor, fontSize: 20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/bucketList');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: kThemeColor, width: 2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
