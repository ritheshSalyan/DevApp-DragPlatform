import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:neumorphic/neumorphic.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({
    Key key,
    @required this.titles,
    @required this.onSelect,
  }) : super(key: key);
  final List<String> titles;
  final void Function(int i) onSelect;
  @override
  _CustomTabbarState createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  List<String> titles = ["Data1,", "Data1,", "Data1,"];

  int selected = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titles = widget.titles;
  }

  @override
  Widget build(BuildContext context) {
    // NeuText("text");
    return NeuCard(
      curveType: CurveType.flat,
      color: neuBackground,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(
          titles.length,
          (index) => InkWell(
            onTap: () {
              setState(() {
                selected = index;
                if (widget.onSelect != null) {
                  widget.onSelect(index);
                }
              });
            },
            child: Transform.rotate(
              origin: Offset(0, 0),
              angle: (22 / 7) / 2,
              child: NeuCard(
                decoration: NeumorphicDecoration(
                  color: neuBackground,
                ),
                curveType: selected == index ? CurveType.emboss : null,
                bevel: selected == index ? 25 : 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: NeuText(
                    titles[index],
                    emboss: selected != index,
                    depth: 10,
                    spread: 2.0,
                    parentColor: neuBackground,
                    style: selected == index
                        ? TextStyle(color: green, fontWeight: FontWeight.bold)
                        : TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
