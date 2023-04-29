import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Screen/Test/Widget/ListTile2.dart';
import 'package:eshop_multivendor/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListTile3.dart';

class TestingClass extends StatefulWidget {
  const TestingClass({Key? key}) : super(key: key);

  @override
  State<TestingClass> createState() => _TestingClassState();
}

class _TestingClassState extends State<TestingClass> {
  bool test = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      appBar: getSimpleAppBar('Testing Only', context),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 500,
                ),
                height: test ? 0 : deviceHeight! * 0.9,
                width: 150,
                color: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Hint',
                        style: TextStyle(
                          fontFamily: 'ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 500,
                ),
                height: !test ? 0 : deviceHeight! * 0.9,
                width: 150,
                color: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Hint',
                        style: TextStyle(
                          fontFamily: 'ubuntu',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 500,
                ),
                height: 150,
                width: test ? 0 : deviceHeight! * 0.9,
                color: Colors.pink,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: Text(
                          'Hello Done',
                          style: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var i = 2;
          if (i == 0) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const SignInFormScreen(),
              ),
            );
          } else if (i == 2) {
            test = !test;
            setState(() {});
          } else { Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AwosomeAnimation(),
              ),
            );}
        },
      ),
    );
  }
}
