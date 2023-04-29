import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/appBar.dart';
import 'Widget/ListTile3.dart';
import 'Widget/ListTile1.dart';
import 'Widget/ListTile2.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      appBar: getSimpleAppBar('Animations', context),
      body: ListView(
        children: [
          getListViewIteam(
            'Simple One',
            0,
          ),
          getListViewIteam(
            'Login SingUp Screen',
            1,
          ),
          getListViewIteam(
            'Awosome Animation',
            2,
          ),
          getListViewIteam(
            'Text Animation',
            3,
          ),
          getListViewIteam(
            'Line Animation',
            4,
          ),
          getListViewIteam(
            'Double Line Animation',
            5,
          ),
          getListViewIteam(
            'Plan Sheet Animation',
            6,
          ),
          getListViewIteam(
            'Matrix Rotation Animation',
            7,
          ),
          getListViewIteam(
            'Double Matrix Rotation Animation',
            8,
          ),
          getListViewIteam(
            'Tringle with radius Animation',
            8,
          ),
          getListViewIteam(
            'polygone Animation',
            8,
          ),
          getListViewIteam(
            'white box Animation',
            8,
          ),
          getListViewIteam(
            'Up and Down Animation',
            8,
          ),
          getListViewIteam(
            'Animated  ListView',
            8,
          ),
          getListViewIteam(
            'Vertical',
            8,
          ),
          getListViewIteam(
            'horizontal',
            8,
          ),
          getListViewIteam(
            'custom painter',
            8,
          ),
        ],
      ),
    );
  }

  getListViewIteam(
    String title,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.grey.withOpacity(0.35),
        child: ListTile(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const TestingClass(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const SignInFormScreen(),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AwosomeAnimation(),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AwosomeAnimation(),
                ),
              );
            } else {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AwosomeAnimation(),
                ),
              );
            }
          },
          leading: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          trailing: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
