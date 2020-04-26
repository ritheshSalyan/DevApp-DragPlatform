
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';

class AlignmentSelector extends StatefulWidget {
  const AlignmentSelector({
    Key key,
    @required this.onSelected,
  }) : super(key: key);
  final void Function(AlignmentGeometry selectedAlignment) onSelected;
  @override
  _AlignmentSelectorState createState() => _AlignmentSelectorState();
}

class _AlignmentSelectorState extends State<AlignmentSelector> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Alignment"),
            Container(
              width: 150,
              height: 153,
              child: GridView.builder(
                  // addAutomaticKeepAlives: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          setState(() {
                            selected = i;
                          });
                          widget.onSelected(intToAlign(selected));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: selected == i ? green : Colors.transparent,
                              border: Border.all(
                                  width: 1, style: BorderStyle.solid)),
                          width: 50,
                          height: 50,
                        ),
                      )),
            ),
          ],
        ),
      ],
    );
  }

  AlignmentGeometry intToAlign(int i) {
    switch (i) {
      case 0:
        return Alignment.topLeft;
      case 1:
        return Alignment.topCenter;
      case 2:
        return Alignment.topRight;
      case 3:
        return Alignment.centerLeft;

      case 4:
        return Alignment.center;

      case 5:
        return Alignment.centerRight;

      case 6:
        return Alignment.bottomLeft;

      case 7:
        return Alignment.bottomCenter;

      case 8:
        return Alignment.bottomRight;
    }
    return Alignment.topLeft;
  }
}
