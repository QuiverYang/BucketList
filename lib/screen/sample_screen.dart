import 'package:flutter/material.dart';

import 'component/panel_widget.dart';

/// 範例頁面，要看元件樣式可以在這邊隨便加
class SampleScreen extends StatelessWidget {
  final String title;

  const SampleScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panelWidth = MediaQuery.of(context).size.width - 48;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
      ),
      body: Center(
        child: PanelWidget(
          panelSize: Size(panelWidth, panelWidth * 0.33),
          title: "Profile",
          titleTextSize: 14,
          contentWidget: Text("AAAAA"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
