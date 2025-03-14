import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/abstract_templet.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/arithmatic/addition.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/conditional.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/custom_print.dart';
import 'package:flutter_drag_and_drop/elements/backend_builder/instructions/update_ui.dart';
import 'package:flutter_drag_and_drop/elements/custom_widget.dart';
import 'package:flutter_drag_and_drop/elements/rootWidget.dart';
import 'package:flutter_drag_and_drop/elements/widgets/appbar_widgets/custom_appbar.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/column.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/row.dart';
import 'package:flutter_drag_and_drop/elements/widgets/layout_widgets/scrolling/listview.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/card.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/container.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/background_elements/scaffold.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/buttons/button.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/display_elements/icons.dart';
import 'package:flutter_drag_and_drop/elements/widgets/ui_elements/display_elements/text.dart';

CustomWidget getWidgetByName(String name) {
  if (widgetNames.keys.contains(name)) {
    return widgetNames[name].copy();
  } else
    return CustomRootWidget(name);
}

Map<String, CustomWidget> widgetNames = {
  "Button": CustomButton(),
  "Text": CustomText(),
  "Icon": CustomIcon(),
  "Scaffold": CustomScaffoldWithAppbar(),
  "Container": CustomContainer(),
  "Card": CustomCard(),
  "Row": CustomRow(),
  "Column": CustomColumn(),
  "ListView": CustomListView(),
  // "Appbar": CustomAppbar(),
};

CustomWidget widgetFromJson(Map<String, dynamic> json) {
  CustomWidget customWidget = getWidgetByName(json[NAME]);
}

CustomInstruction getFunctionByName(String name) {
  if (instructions.containsKey(name)) {
    return instructions[name].copy();
  }
  return CustomUpdateUi();
}

Map<String, CustomInstruction> instructions = {
  "Arithmatic Operation": CustomArithmaticOperation(),
  "Update UI": CustomUpdateUi(),
  "Print": CustomPrint(),
  "Condition": CustomConditionalOperation(),
};
