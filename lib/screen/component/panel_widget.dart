import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final Size panelSize;
  final String title;
  final Widget contentWidget;
  final double contentPaddingX;
  final double contentPaddingY;

  final String panelTitle;
  final double strokeWidth;
  final double radius;
  final double titleRadius;
  final double titlePaddingX;
  final double titlePaddingY;
  final double titleTextSize;
  final Color panelColor;
  final Color panelBgColor;
  final Color panelTitleColor;

  const PanelWidget({
    Key key,
    this.panelSize,
    this.title,
    this.contentWidget,
    this.contentPaddingX = 16,
    this.contentPaddingY = 8,
    this.panelTitle,
    this.strokeWidth = 2,
    this.radius = 8,
    this.titleRadius = 4,
    this.titlePaddingX = 16,
    this.titlePaddingY = 4,
    this.titleTextSize = 14,
    this.panelColor = Colors.cyanAccent,
    this.panelBgColor = Colors.black26,
    this.panelTitleColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: panelSize,
          painter: PanelPainter(
            panelSize: panelSize,
            panelTitle: title,
            strokeWidth: strokeWidth,
            radius: radius,
            titleRadius: titleRadius,
            titlePaddingX: titlePaddingX,
            titlePaddingY: titlePaddingY,
            titleTextSize: titleTextSize,
            panelColor: panelColor,
            panelBgColor: panelBgColor,
            panelTitleColor: panelTitleColor,
          ),
        ),
        Positioned(
          top: titlePaddingY + titleTextSize + titlePaddingY + contentPaddingY,
          left: contentPaddingX,
          child: contentWidget,
        )
      ],
    );
  }
}

class PanelPainter extends CustomPainter {
  final Size panelSize;
  final String panelTitle;
  final double strokeWidth;
  final double radius;
  final double titleRadius;
  final double titlePaddingX;
  final double titlePaddingY;
  final double titleTextSize;
  final Color panelColor;
  final Color panelBgColor;
  final Color panelTitleColor;

  Paint _borderPaint = Paint();
  Paint _bgPaint = Paint();
  Paint _titleBgPaint = Paint();

  Path _titleBgPath = Path();

  PanelPainter({
    this.panelSize,
    this.panelTitle,
    this.strokeWidth,
    this.radius,
    this.titleRadius,
    this.titlePaddingX,
    this.titlePaddingY,
    this.titleTextSize,
    this.panelColor,
    this.panelBgColor,
    this.panelTitleColor,
  }) {
    /// initiate paint for panel border
    _borderPaint.color = panelColor;
    _borderPaint.isAntiAlias = true;
    _borderPaint.strokeCap = StrokeCap.round;
    _borderPaint.strokeWidth = strokeWidth;
    _borderPaint.style = PaintingStyle.stroke;

    /// initiate paint for panel background
    _bgPaint.color = panelBgColor;
    _bgPaint.isAntiAlias = true;
    _bgPaint.strokeCap = StrokeCap.round;
    _bgPaint.strokeWidth = strokeWidth;
    _bgPaint.style = PaintingStyle.fill;

    /// initiate paint for panel title background
    _titleBgPaint.color = panelColor;
    _titleBgPaint.isAntiAlias = true;
    _titleBgPaint.strokeCap = StrokeCap.round;
    _titleBgPaint.strokeWidth = strokeWidth;
    _titleBgPaint.style = PaintingStyle.fill;

    /// initiate path for panel title background
    final titleHeight = titleTextSize + titlePaddingY * 2;
    final titleWidth = panelSize.width * 0.4;
    final titleWidthShort = titleWidth * 0.85;
    _titleBgPath.moveTo(0, titleRadius);
    _titleBgPath.lineTo(titleRadius, 0);
    _titleBgPath.lineTo(titleWidth, 0);
    _titleBgPath.lineTo(titleWidthShort, titleHeight);
    _titleBgPath.lineTo(0, titleHeight);
    _titleBgPath.close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final panelMainArea = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    );

    // draw bg
    canvas.drawRRect(panelMainArea, _bgPaint);

    // draw border
    canvas.drawRRect(panelMainArea, _borderPaint);

    // draw panel title bg
    canvas.drawPath(_titleBgPath, _titleBgPaint);

    // draw panel title
    if (panelTitle != null) {
      TextSpan span = new TextSpan(
        style: TextStyle(
          color: panelTitleColor,
          fontSize: titleTextSize,
        ),
        text: panelTitle,
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(titlePaddingX, titlePaddingY));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
