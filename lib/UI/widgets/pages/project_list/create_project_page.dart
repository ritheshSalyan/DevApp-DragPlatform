
import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/responsive_textfield.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:neumorphic/neumorphic.dart';

class CreateProjectPage extends StatelessWidget {
  CreateProjectPage({
    Key key,
    this.createProject,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  void Function(String name) createProject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neuBackground,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
          color: neuBackground,
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        // iconTheme: IconThemeData(color:Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundDots(),
          CustomPaint(
            painter: ThumbPainter(thumbColor: green),
            size: MediaQuery.of(context).size,
            willChange: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Let's name your project",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(),
              Form(
                key: formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ResponsiveTextField(
                      lableText: "Project Name *",
                      controller: textEditingController,
                      validate: (text) {
                        if (text == null || text.isEmpty || text.length > 50) {
                          return TextFieldState.ERROR;
                        }
                        if (text.length <= 3 || text.length > 30) {
                          return TextFieldState.WARNING;
                        }
                        return TextFieldState.VALID;
                      },
                      setMessage: (textState, text) {
                        if (textState == TextFieldState.ERROR) {
                          if (text == null || text.isEmpty) {
                            return "Project Name Cannot be Empty";
                          }
                          return "Project Name is Too Large.";
                        }
                        if (textState == TextFieldState.WARNING) {
                          if (text.length <= 3) {
                            return "Project Name is Too short";
                          }
                          return "Project Name is Large. It might get Trimmed";
                        }
                        return null;
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NeuButton(
                      child: Text("Create Project"),
                      decoration: NeumorphicDecoration(
                        color: neuBackground,
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Navigator.of(context).pop(textEditingController.text);
                          createProject(textEditingController.text);
                        }
                      }),
                ],
              ),
              SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          top: size.height * 0.7,
          left: size.width * 0.8,
          child: Container(
            width: size.height * 0.1,
            height: size.height * 0.1,
            color: neuBackground,
            child: GridView.builder(
              itemCount: 40,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 7,
                  childAspectRatio: 1,
                  crossAxisSpacing: 7),
              itemBuilder: (context, i) => Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: green,
                  // borderRadius: BorderRadius.circular(5)
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.65,
          left: size.width * 0.35,
          child: Container(
            width: size.height * 0.25,
            height: size.height * 0.25,
            color: neuBackground,
            child: GridView.builder(
                itemCount: 200,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1,
                    crossAxisSpacing: 7),
                itemBuilder: (context, i) => Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: green,
                        // borderRadius: BorderRadius.circular(5)
                      ),
                    )),
          ),
        ),
        Positioned(
          top: 0,
          left: size.width * 0.75,
          child: Container(
            width: size.height * 0.25,
            height: size.height * 0.25,
            color: neuBackground,
            child: GridView.builder(
                itemCount: 200,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1,
                    crossAxisSpacing: 7),
                itemBuilder: (context, i) => Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: green,
                        // borderRadius: BorderRadius.circular(5)
                      ),
                    )),
          ),
        ),
        Positioned(
          top: size.height * 0.8,
          left: size.width * 0.9,
          child: Container(
            width: size.height * 0.25,
            height: size.height * 0.25,
            color: neuBackground,
            child: GridView.builder(
                itemCount: 200,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1,
                    crossAxisSpacing: 7),
                itemBuilder: (context, i) => Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: green,
                        // borderRadius: BorderRadius.circular(5)
                      ),
                    )),
          ),
        ),
        Positioned(
          top: size.height * 0.0,
          left: size.width * 0.2,
          child: Container(
            width: size.height * 0.1,
            height: size.height * 0.15,
            color: neuBackground,
            child: GridView.builder(
                itemCount: 45,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1,
                    crossAxisSpacing: 7),
                itemBuilder: (context, i) => Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: green,
                        // borderRadius: BorderRadius.circular(5)
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}

class ThumbPainter extends CustomPainter {
  const ThumbPainter({this.thumbColor, this.fullThumbColor: false});

  final Color thumbColor;
  final bool fullThumbColor;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawShadow(
    //   Path()
    //     ..addOval(
    //       Rect.fromCircle(center: Offset(0.5, 2.0), radius: size.width * 1.8),
    //     ),
    //   Colors.black,
    //   3.0,
    //   true,
    // );
    // canvas.drawCircle(
    //     Offset(0.0, size.height * 0.4),
    //     size.height,
    //     Paint()
    //       ..color = Colors.white
    //       ..style = PaintingStyle.fill);
    // if (thumbColor != null) {
    canvas.drawCircle(
        Offset(-size.width * 0.1, size.height * 0.4),
        size.height * (fullThumbColor ? 1.0 : 0.65),
        Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill);
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
