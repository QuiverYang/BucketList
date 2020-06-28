import 'package:plannerx/utilities/fakedata.dart';
import 'package:flutter/cupertino.dart';

class QuestData {
  final String category;
  final String title;
  final String deadline;
  final int progressNow;
  final int progressTotal;
  final String iconData;

  QuestData({
    @required this.category,
    @required this.title,
    @required this.deadline,
    @required this.progressNow,
    @required this.progressTotal,
    @required this.iconData,
  });

  String iconAsset() => categoryIconAsset[category];

  String imageAsset() => categoryImageAsset[category];
}
