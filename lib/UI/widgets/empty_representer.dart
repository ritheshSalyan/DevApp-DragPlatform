import 'package:flutter/material.dart';

class EmptyRepresenter extends StatelessWidget {
  final double width;
  final double height;
  const EmptyRepresenter({Key key,this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.transparent,
      key: ValueKey(0),
      width: width??MediaQuery.of(context).size.width,
      height: height??MediaQuery.of(context).size.height,
      decoration: BoxDecoration(border: Border.all()),
      child: CustomPaint(
        painter: CrossPainter(),
      ),
    );
  }
}

class CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey[800];
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.0;

    var path = Path();

    path.lineTo(size.width, size.height);
    path.moveTo(0, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
