import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/custom_function.dart';

class InstructionNode extends StatefulWidget {
  InstructionNode(
      {Key key,
      @required this.shouldpositionUpdate,
      // this.nodePoint,
      @required this.function,
      this.linkedNode})
      : super(key: key);

  final bool Function(Offset newPosition) shouldpositionUpdate;
  LinkedListNode linkedNode;
  // NodePoint nodePoint;
  CustomFunction function;

  @override
  _InstructionNodeState createState() => _InstructionNodeState();
}

class _InstructionNodeState extends State<InstructionNode> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: widget.linkedNode.position.dy,
      left: widget.linkedNode.position.dx,
      child: 
      // CustomPaint(
        // size: Size(size.width * 0.5, size.height * 0.75),
        // painter: LinesPainter(
            // widget.linkedNode?.to?.recievePoint, widget.linkedNode?.sendPoint),
        // child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DragTarget<LinkedListNode>(
              key: widget.linkedNode.globalKeyForRecieve,
              onAccept: (data) {
                data.setSource(widget.linkedNode);
                setState(() {});
              },
              builder: (context, snapshot, defe) {
                return Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    width: 20,
                    height: 10,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(15),
                    //     bottomRight: Radius.circular(15),
                    //   ),
                    //   color: Colors.indigo,
                    // ),
                  ),
                );
              },
            ),
            Draggable(
              onDragEnd: (details) {
                widget.shouldpositionUpdate(details.offset);
              },
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.indigo,
                  child: widget.linkedNode.instruction
                      .build(context, widget.function),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.indigo,
                child: widget.linkedNode.instruction
                    .build(context, widget.function),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Draggable<LinkedListNode>(
                onDragCompleted: () {
                },
                data: widget.linkedNode,
                feedback: Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,\
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.indigo),
                ),
                child: Container(
                  key: widget.linkedNode.globalKeyForSend,
                  width: 20,
                  height: 10,
                  // decoration: BoxDecoration(
                  //     // shape: BoxShape.circle,\
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(15),
                  //       bottomRight: Radius.circular(15),
                  //     ),
                  //     color: Colors.indigo),
                ),
              ),
            ),
          ],
        ),
      // ),
    );
  }
}


class LinesPainter extends CustomPainter {
  final Offset start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    print("IN PAINTER $start $end");
    if (start == null || end == null) return;
    print("Before Painting");
    canvas.drawLine(
        start,
        end,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.green);
    print("After Painting");
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate?.start != start || oldDelegate?.end != end;
  }
}
