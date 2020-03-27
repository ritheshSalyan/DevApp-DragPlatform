import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic/neumorphic.dart';

class CustomNeumorpicRadio extends StatefulWidget {
  final Map<dynamic,Widget> children;
  final String lable;
  final Function(dynamic) onSelect;
  final dynamic initialSelect;

  const CustomNeumorpicRadio({Key key, @required this.lable, @required  this.onSelect, @required  this.children, @required  this.initialSelect}) : super(key: key);
  @override

  _CustomNeumorpicRadioState createState() => _CustomNeumorpicRadioState();
}

class _CustomNeumorpicRadioState extends State<CustomNeumorpicRadio> {
  dynamic switchValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = widget.initialSelect;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Returnninf nscnlnlsvasv");

    return
        Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
           widget.lable??"Select",
            style: TextStyle(
              fontWeight: FontWeight.w700,
        
            ),
          ),
        ),
        NeuSwitch(
          backgroundColor: neuBackground,
          onValueChanged: (val) {
            setState(() {
              switchValue = val;
              if(widget.onSelect!=null){
                widget.onSelect(val);
              }
            });
          },
          groupValue: switchValue,
          children:widget.children
        ),
      ],
    );
  }
}
