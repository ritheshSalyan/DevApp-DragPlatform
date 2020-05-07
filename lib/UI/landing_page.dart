import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:neumorphic/neumorphic.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: neuBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(top: 15),
          child: RichText(
            text: TextSpan(
              text: "Build ",
              style:
                  Theme.of(context).textTheme.headline5.copyWith(color: green),
              children: [
                TextSpan(
                    text: "It", style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(onPressed: () {}, child: Text("About Us")),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: NeuButton(
                padding: EdgeInsets.zero,
                child: Container(
                  color: green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: neuBackground,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: NeumorphicDecoration(
                  color: neuBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignInPage(
                      pageViewStates: PageViewStates.SIGN_IN,
                    ),
                  ));
                }),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: size.height * 0.7,
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
                      )),
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
          ListView(
            children: <Widget>[
              // Container(
              //   color: Colors.red,
              //   height: size.height * 0.1,
              //   child: Row(
              //     children: <Widget>[],
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: size.height * 0.6,
                    width: size.width * 0.35,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Build \nYour \nApp ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 2,
                              color: Colors.grey,
                              height: size.height * 0.4,
                            ),
                            SizedBox(width: 15),
                            Flexible(
                                child: Text(
                                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose")),
                          ],
                        ),
                        NeuButton(
                            decoration: NeumorphicDecoration(
                              color: neuBackground,
                            ),
                            // padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Start Building"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(AntDesign.arrowright)
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignInPage(
                                  pageViewStates: PageViewStates.SIGN_UP,
                                ),
                              ));
                            }),
                      ],
                    ),
                  ),
                  NeuCard(
                    width: size.width * 0.5,
                    height: size.height * 0.6,
                    curveType: CurveType.emboss,
                    bevel: 15,
                    color: neuBackground,
                    child: Image.asset(
                      "assets/images/landing_image.png",
                      fit: BoxFit.fitWidth,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
