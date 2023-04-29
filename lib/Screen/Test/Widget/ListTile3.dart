import 'package:eshop_multivendor/Helper/String.dart';
import 'package:flutter/material.dart';

class AwosomeAnimation extends StatefulWidget {
  const AwosomeAnimation({Key? key}) : super(key: key);

  @override
  State<AwosomeAnimation> createState() => _AwosomeAnimationState();
}

class _AwosomeAnimationState extends State<AwosomeAnimation>
    with TickerProviderStateMixin {
  // for first container aniomation
  late final AnimationController firstAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  late final Animation<double> containerHeghitAnimation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: firstAnimationController,
          curve: const Interval(0.0, 0.50, curve: Curves.linear)));

  late final Animation<double> IconAnimationAnimation =
      Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
          parent: firstAnimationController,
          curve: const Interval(0.50, 1.0, curve: Curves.linear)));

  late final Animation<double> circleRadiusAnimation =
      Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
          parent: firstAnimationController,
          curve: const Interval(0.50, 1.0, curve: Curves.linear)));

  late final Animation<double> CircularContainerAnimation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: firstAnimationController,
          curve: const Interval(0.50, 1.0, curve: Curves.linear)));
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
        onPressed: () {
          if (firstAnimationController.isCompleted) {
            firstAnimationController.reverse().then((value) => {});
          } else {
            firstAnimationController.forward();
          }
        },
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: deviceWidth,
              height: deviceHeight,
              color: Color(0xffFFFFFF),
            ),
          ),
          getFirstContainer(),
          getSecondConatiner(),
          fullSizecomplateContainer(),
          getIcon(),
          // getMainContainer(),
          // singUpContainer(),
        ],
      ),
    );
  }

  getIcon() {
    return AnimatedBuilder(
        animation: firstAnimationController,
        builder: (context, child) {
          return RotationTransition(
            turns: AlwaysStoppedAnimation(
                180 * IconAnimationAnimation.value / 360),
            child: Center(
              child: Icon(Icons.home, color: Colors.white, size: 200),
            ),
          );
        });
  }

  fullSizecomplateContainer() {
    return AnimatedBuilder(
        animation: firstAnimationController,
        builder: (context, child) {
          return Center(
            child: Container(
              child: Container(
                width: deviceWidth! * (CircularContainerAnimation.value * 2),
                decoration: BoxDecoration(
                    color: Color(0xff42B75A),
                    border: Border.all(
                      color: Color(0xff42B75A),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(300 * circleRadiusAnimation.value))
                    // shape: BoxShape.circle,
                    ),
                height: deviceHeight! * 2 * CircularContainerAnimation.value,
                // color: Color(0xff42B75A),
              ),
            ),
          );
        });
  }

  getSecondConatiner() {
    return AnimatedBuilder(
      animation: firstAnimationController,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          child: Container(
            width: deviceWidth,
            height: (deviceHeight! * 0.5) * containerHeghitAnimation.value,
            color: Color(0xff51C569),
          ),
        );
      },
    );
  }

  getFirstContainer() {
    return AnimatedBuilder(
      animation: firstAnimationController,
      builder: (context, child) {
        return Positioned(
          top: 0,
          child: Container(
            width: deviceWidth,
            height: (deviceHeight! * 0.5) * containerHeghitAnimation.value,
            color: Color(0xff51C569),
          ),
        );
      },
    );
  }
}
