import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:flutter/cupertino.dart';

// 跳出 picker view
Future<String> showDragoonCupertinoPicker(
  BuildContext context,
  Map<String, dynamic> pickData, {
  String title,
  bool loop = true,
}) async {
  String selected = '';
  if (pickData != null) {
    List<String> dataList = [];
    pickData.forEach((key, value) {
      dataList.add(key);
    });
    dataList.sort((a, b) => a.compareTo(b));
    List<Text> options = dataList
        .map((e) => Text(
              e,
              style: TextStyle(color: kThemeColor),
            ))
        .toList();

    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(title ?? ''),
              backgroundColor: kTextColor,
              leading: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context, selected);
                  selected = '';
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    Navigator.pop(context, selected);
                    if (selected == '') {
                      selected = dataList[0];
                    }
                  },
                )
              ],
            ),
            body: Container(
              child: CupertinoPicker(
                // 半透明，把material app 的themeData-BottomSheetThemeData改成透明
                backgroundColor: Color.fromARGB(200, 0, 0, 0),
                children: options,
                itemExtent: 30, //height of each item
                looping: loop,
                onSelectedItemChanged: (int index) {
                  selected = dataList[index];
                },
              ),
            ),
          );
        });
  }
  return selected;
}
