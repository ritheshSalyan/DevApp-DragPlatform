import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class WidthSelector extends StatelessWidget {
final  Function(double) onChanged;
final String lable;
final double initialValue;
  const WidthSelector({Key key, this.onChanged, this.lable, this.initialValue = 1.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
           lable??"",
            style: TextStyle(
              fontWeight: FontWeight.w700,
        
            ),
          ),
        ),
          ChangeNotifierProvider<SliderController>(
            create: (context) => SliderController(
                onChanged,
                initialValue
            ),
            child: Consumer<SliderController>(builder: (context, controller, _) {
              return NeumorphicSlider(
                
                value: controller.value,
                style: SliderStyle(accent: green, variant: green.withAlpha(100)),
                min: 0,
                max: 1.0,
                onChanged: controller.onChanged,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class SliderController with ChangeNotifier {
  double value = 0.5;
  // SliderController({this.value})
  final  Function(double) sendSelected;

  SliderController(this.sendSelected,this.value);

  void onChanged(double newValue) {
    value = newValue;
    if(sendSelected!=null){
      sendSelected(value);
    }
    notifyListeners();
  }
}
