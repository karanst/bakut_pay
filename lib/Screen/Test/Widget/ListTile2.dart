import 'package:flutter/material.dart';

// Colors for app
const Color primary = Color(0xff3e66ff);
const Color secondary = Color(0xff1f1567);
const Color fontColor = Color(0xff79749c);
const Color lightWhite1 = Color(0xffEEF2F9);

class SignInFormScreen extends StatefulWidget {
  const SignInFormScreen({Key? key}) : super(key: key);

  @override
  State<SignInFormScreen> createState() => _SignInFormScreenState();
}

class _SignInFormScreenState extends State<SignInFormScreen>
    with TickerProviderStateMixin {
  double? width, height;
  bool singupContantShow = false;
  bool widthforsingup = false;

  //============================================================================
  //======================== Sing IN Button ====================================

  late final AnimationController singInController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  late final Animation<double> FontSizeAnimation =
      Tween<double>(begin: 14, end: 0).animate(CurvedAnimation(
          parent: singInController,
          curve: const Interval(0.0, 0.30, curve: Curves.linear)));

  late final Animation<double> CircleAnimation =
      Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
          parent: singInController,
          curve: const Interval(0.70, 1, curve: Curves.linear)));
  late final Animation<double> DoneIconAnimation =
      Tween<double>(begin: 0, end: 500).animate(CurvedAnimation(
          parent: singInController,
          curve: const Interval(0.0, 1.0, curve: Curves.linear)));
  late final Animation<double> BorderAnimation =
      Tween<double>(begin: 25, end: 10).animate(CurvedAnimation(
          parent: singInController,
          curve: const Interval(0.0, 1.0, curve: Curves.linear)));

  //============================================================================
  //============================================================================

  //============================================================================
  //======================== For SingUP Container ==============================

  late final AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

// for height

  late final Animation<double> firstHeightAnimation =
      Tween<double>(begin: 0.22, end: 0.45).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.75, curve: Curves.linear)));
  late final Animation<double> secondHeightAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.75, 1.0, curve: Curves.linear)));
// for width
  late final Animation<double> widthAnimation =
      Tween<double>(begin: 0.0, end: 0.50).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.50, curve: Curves.easeIn)));
  late final Animation<double> secondWidthAnimation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.99, curve: Curves.easeIn)));

//
  late final Animation<double> containerAnimation =
      Tween<double>(begin: 1, end: 5).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.5, 1, curve: Curves.ease)));

  // extra Height
  late final Animation<double> extraHightForSingupAnimation =
      Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.7, 1, curve: Curves.ease)));

  //============================================================================
  //============================================================================

  @override
  void dispose() {
    singInController.dispose();
    animationController.dispose();
    super.dispose();
  }

  getCloneContainer() {
    return Positioned(
      top: height! * 0.25,
      left: width! * 0.075,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: width! * 0.85,
          height: height! * 0.61,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          // color:Colors.white,
        ),
      ),
    );
  }

  getMainContainer() {
    return Positioned(
      top: height! * 0.25,
      left: width! * 0.05,
      child: Opacity(
        opacity: 1,
        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: width! * 0.9,
          height: height! * 0.59,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.radio_button_checked,
                      color: primary,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "SmartKit",
                      style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                getSizedBox(15, 0),
                const Text(
                  "Log In to SmartKit",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                getSizedBox(18, 0),
                getText("E-mail", fontColor),
                getSizedBox(10, 0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: fontColor,
                      width: 1,
                    ),
                  ),
                  // width: width! * 0.6,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: TextFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.mail_outline_outlined),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      minLines: null,
                      maxLines: 1,
                      expands: false,
                    ),
                  ),
                ),
                getSizedBox(10, 0),
                getText("Password", fontColor),
                getSizedBox(10, 0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: fontColor,
                      width: 1,
                    ),
                  ),
                  // width: width! * 0.6,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: TextFormField(
                      readOnly: false,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.lock),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      minLines: null,
                      maxLines: 1,
                      expands: false,
                    ),
                  ),
                ),
                getSizedBox(15, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Forgot your Password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                getSizedBox(15, 0),
                AnimatedBuilder(
                    animation: singInController,
                    builder: (context, child) {
                      return InkWell(
                        onTap: () {
                          if (singInController.isCompleted) {
                            singInController
                                .reverse()
                                .then((value) => print("Animation reversed"));
                          } else {
                            singInController.forward();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: fontColor,
                              width: 1,
                            ),
                          ),
                          // width: width! * 0.6,
                          height: 50,
                          width: width,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: DoneIconAnimation.value,
                                  height: DoneIconAnimation.value,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(
                                        BorderAnimation.value),
                                  ),
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.done,
                                  size: CircleAnimation.value,
                                  color: Colors.white,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizeAnimation.value,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                getSizedBox(15, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          "https://icon-library.com/images/google-login-icon/google-login-icon-24.jpg",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          "https://i.pinimg.com/564x/2b/79/51/2b7951ca3923b28a9e77518b19d1ea46--how-to-get-learn-how.jpg",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          "https://help.twitter.com/content/dam/help-twitter/brand/logo.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSizedBox(double valueHigh, double valueWidh) {
    return SizedBox(
      height: valueHigh,
      width: valueHigh,
    );
  }

  getText(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        //   fontWeight: FontWeight.bold,
      ),
    );
  }

  singUpContainer() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        if (secondHeightAnimation.status.toString() ==
            "AnimationStatus.dismissed") {
          singupContantShow = false;
          widthforsingup = true;
        }
        if (secondHeightAnimation.status.toString() ==
            "AnimationStatus.completed") {
          singupContantShow = true;
          widthforsingup = true;
        }
        if (secondHeightAnimation.status.toString() ==
            "AnimationStatus.forward") {
          singupContantShow = false;
          widthforsingup = true;
        }

        if (secondHeightAnimation.status.toString() ==
            "AnimationStatus.reverse") {
          singupContantShow = false;
          widthforsingup = true;
        }

        final topPaddingPercentage =
            firstHeightAnimation.value - 0.23 * secondHeightAnimation.value;

        final leftPaddingPercentage =
            widthAnimation.value - 0.5 * secondWidthAnimation.value;
        return Positioned(
          top: height! * topPaddingPercentage,
          right: width! * leftPaddingPercentage, // slideAnimation3.value,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Opacity(
              opacity: 1,
              child: Container(
                padding: EdgeInsets.all(singupContantShow ? 30.0 : 0.0),

                width: (width! * (0.2 * containerAnimation.value)) -
                    (singupContantShow ? 20 : 0),
                height: height! * (0.1 * containerAnimation.value) +
                    (widthforsingup ? extraHightForSingupAnimation.value : 0),
                child: singupContantShow
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.radio_button_checked,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "SmartKit",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    if (animationController.isCompleted) {
                                      animationController.reverse().then(
                                          (value) =>
                                              print("Animation reversed"));
                                    } else {
                                      animationController.forward();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                              ],
                            ),
                            getSizedBox(10, 0),
                            const Text(
                              "Sign Up for Free, Now.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            getSizedBox(15, 0),
                            getText("Username", Colors.white),
                            getSizedBox(10, 0),
                            Container(
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              // width: width! * 0.6,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  readOnly: false,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  minLines: null,
                                  maxLines: 1,
                                  expands: false,
                                ),
                              ),
                            ),
                            getSizedBox(10, 0),
                            getText("E-mail", Colors.white),
                            getSizedBox(10, 0),
                            Container(
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              // width: width! * 0.6,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  readOnly: false,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.mail_outline_outlined,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  minLines: null,
                                  maxLines: 1,
                                  expands: false,
                                ),
                              ),
                            ),
                            getSizedBox(10, 0),
                            getText("Password", Colors.white),
                            getSizedBox(10, 0),
                            Container(
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              // width: width! * 0.6,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  readOnly: false,
                                  textInputAction: TextInputAction.newline,
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  minLines: null,
                                  maxLines: 1,
                                  expands: false,
                                ),
                              ),
                            ),
                            getSizedBox(15, 0),
                            InkWell(
                              onTap: () {
                                //
                                print("Tapped");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                // width: width! * 0.6,
                                height: 50,
                                width: width,
                                child: const Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            getSizedBox(15, 0),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: const [
                            //     Text(
                            //       "Forgot your Password?",
                            //       style: TextStyle(color:Colors.white),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (animationController.isCompleted) {
                            animationController
                                .reverse()
                                .then((value) => print("Animation reversed"));
                          } else {
                            animationController.forward();
                          }
                        },
                        child: const Center(
                          child: Icon(
                            Icons.subject,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                  color: primary,
                ),
                // color:Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: lightWhite1,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: lightWhite1,
          ),
          getCloneContainer(),
          getMainContainer(),
          singUpContainer(),
        ],
      ),
    );
  }
}
