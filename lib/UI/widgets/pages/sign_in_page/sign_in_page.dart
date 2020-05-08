import 'package:flutter/material.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/responsive_textfield.dart';
import 'package:flutter_drag_and_drop/UI/widgets/common/responsive_textfield/textfield_enums.dart';
import 'package:flutter_drag_and_drop/UI/widgets/pages/sign_in_page/sign_in_view_model.dart';
import 'package:flutter_drag_and_drop/constants.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  final PageViewStates pageViewStates;

  const SignInPage({Key key, this.pageViewStates}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  PageViewStates pageViewStates; // = PageViewStates.SIGN_IN;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewStates = widget.pageViewStates;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SignInViewModel>(
      create: (context) => SignInViewModel(widget.pageViewStates),
      child: Consumer<SignInViewModel>(builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: AnimatedSwitcher(
            switchInCurve: Curves.easeInExpo,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            duration: Duration(milliseconds: 350),
            child: viewModel.pageViewStates == PageViewStates.SIGN_IN
                ? buildSignIn(size, context, viewModel)
                : buildSignUp(size, context, viewModel),
          ),
        );
      }),
    );
  }

  Row buildSignUp(
    Size size,
    BuildContext context,
    SignInViewModel viewModel,
  ) {
    return Row(
      key: ValueKey(0),
      children: <Widget>[
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome Back to \nBUILD IT!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                "Already Have Account?",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NeuButton(
                      decoration: NeumorphicDecoration(
                          color: green, //Colors.white
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "SIGN IN",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        // setState(() {
                        //   pageViewStates = PageViewStates.SIGN_IN;
                        // });
                        viewModel.swapView();
                      }),
                ],
              )
            ],
          ),
        ),
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: neuBackground, //Colors.white, //
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(height: 40),

                // NeuCard(
                //   curveType: CurveType.flat,
                //   decoration: NeumorphicDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: neuBackground,
                //       clipBehavior: Clip.hardEdge),
                // child:
                Container(
                  width: size.width * 0.35,
                  child: ResponsiveTextField(
                    controller: viewModel.emailController,
                    lableText: "Email Addrress",
                    validate: (String data) {
                      return TextFieldState.VALID;
                    },
                    setMessage: (textFieldState, data) {
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 30),
                // ),
                //  NeuCard(
                //   curveType: CurveType.flat,
                //   decoration: NeumorphicDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: neuBackground,
                //       clipBehavior: Clip.hardEdge),
                // child:
                Container(
                  width: size.width * 0.35,
                  child: ResponsiveTextField(
                    controller: viewModel.passwordController,
                    lableText: "Password",
                    validate: (String data) {
                      return TextFieldState.VALID;
                    },
                    setMessage: (textFieldState, data) {
                      return null;
                    },
                  ),
                ),
                // ),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NeuButton(
                        decoration: NeumorphicDecoration(
                            color: neuBackground, //Colors.white
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("SIGN UP"),
                        onPressed: () {
                          viewModel.signUp(context);

                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildSignIn(Size size, BuildContext context, SignInViewModel viewModel) {
    return Row(
      key: ValueKey(1),
      children: <Widget>[
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: neuBackground, //Colors.white, //
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(height: 40),

                // NeuCard(
                //   curveType: CurveType.flat,
                //   decoration: NeumorphicDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: neuBackground,
                //       clipBehavior: Clip.hardEdge),
                // child:
                Container(
                  width: size.width * 0.35,
                  child: ResponsiveTextField(
                    controller: viewModel.emailController,

                    lableText: "Email Addrress",
                    validate: (String data) {
                      return TextFieldState.VALID;
                    },
                    setMessage: (textFieldState, data) {
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 30),
                // ),
                //  NeuCard(
                //   curveType: CurveType.flat,
                //   decoration: NeumorphicDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: neuBackground,
                //       clipBehavior: Clip.hardEdge),
                // child:
                Container(
                  width: size.width * 0.35,
                  child: ResponsiveTextField(
                    controller: viewModel.passwordController,
                    lableText: "Password",
                    validate: (String data) {
                      return TextFieldState.VALID;
                    },
                    setMessage: (textFieldState, data) {
                      return null;
                    },
                  ),
                ),
                // ),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NeuButton(
                        decoration: NeumorphicDecoration(
                            color: neuBackground, //Colors.white
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("SIGN IN"),
                        onPressed: () {
                          viewModel.signIn(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to \nBUILD IT!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                "New Here?",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NeuButton(
                      decoration: NeumorphicDecoration(
                          color: green, //Colors.white
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "SIGN UP",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        // setState(() {
                        //   pageViewStates = PageViewStates.SIGN_UP;
                        // });
                        viewModel.swapView();
                      }),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

enum PageViewStates { SIGN_IN, SIGN_UP }
