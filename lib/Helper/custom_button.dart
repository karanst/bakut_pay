import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String? text;
  final Function? onTap;
  final Color? color;
  final Color? textColor;

  CustomButton(this.text, {this.onTap, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                 colors.primary,
                  colors.primary,
                ],
                stops: [
                  0.3,
                  0.7
                ]),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: color == theme.scaffoldBackgroundColor
                    ? theme.primaryColorLight
                    : Colors.transparent)),
        child: textColor == null
            ? Text(text!, style: theme.textTheme.button)
            : Text(
                text!,
                style: TextStyle(
                  color: colors.whiteTemp,
                  fontWeight: FontWeight.w600
                ),
                // style:
                // theme.textTheme.button!.copyWith(
                //     foreground: Paint()
                //       ..shader = LinearGradient(
                //         colors: [
                //           theme.primaryColor,
                //           theme.primaryColorLight,
                //         ],
                //       ).createShader(Rect.fromLTWH(100, 100, 200, 1500))),
              ),
      ),
    );
  }
}


class CustomHeading extends StatelessWidget {
  final String? heading;

  const CustomHeading({Key? key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      color: Theme.of(context).dividerColor,
      child: Text(heading!),
    );
  }
}
