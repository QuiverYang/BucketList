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
    this.panelTitleColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: panelSize,
          painter: PanelPainter(
            panelTitle: title,
            strokeWidth: strokeWidth,
            radius: radius,
            titleRadius: titleRadius,
            titlePaddingX: titlePaddingX,
            titlePaddingY: titlePaddingY,
            titleTextSize: titleTextSize,
            panelColor: panelColor,
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
  final String panelTitle;
  final double strokeWidth;
  final double radius;
  final double titleRadius;
  final double titlePaddingX;
  final double titlePaddingY;
  final double titleTextSize;
  final Color panelColor;
  final Color panelTitleColor;

  PanelPainter({
    this.panelTitle,
    this.strokeWidth,
    this.radius,
    this.titleRadius,
    this.titlePaddingX,
    this.titlePaddingY,
    this.titleTextSize,
    this.panelColor,
    this.panelTitleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // draw border
    Paint borderPaint = Paint();
    borderPaint.color = panelColor;
    borderPaint.isAntiAlias = true;
    borderPaint.strokeCap = StrokeCap.round;
    borderPaint.strokeWidth = strokeWidth;
    borderPaint.style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        size.width,
        size.height,
        Radius.circular(radius),
      ),
      borderPaint,
    );

    // draw panel title bg
    final titleHeight = titleTextSize + titlePaddingY * 2;
    final titleWidth = size.width * 0.4;
    final titleWidthShort = titleWidth * 0.85;
    Path path = Path();
    path.moveTo(0, titleRadius);
    path.lineTo(titleRadius, 0);
    path.lineTo(titleWidth, 0);
    path.lineTo(titleWidthShort, titleHeight);
    path.lineTo(0, titleHeight);
    path.close();
    borderPaint.style = PaintingStyle.fill;
    canvas.drawPath(path, borderPaint);

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
