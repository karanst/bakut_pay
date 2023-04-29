import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/material.dart';


class AuthTextField extends StatelessWidget {
  final Widget? iconImage;
  final String? hintText;
  final String? Function(String?)? validatior;
  final bool obsecureText;
  final bool? enabled;
  final int? length;
  final  TextInputType? keyboardtype;
  var suffixIcons;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  AuthTextField({Key? key, this.iconImage,this.suffixIcons,this.hintText, this.controller, required this.obsecureText, this.validatior, this.keyboardtype,this.enabled, this.length, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset:  Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 0.5,
                spreadRadius: 0.5,
              ),
            ]
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: iconImage,
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: 60,
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //   borderRadius: BorderRadius.circular(40),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Colors.grey,
                //         offset:  Offset(
                //           1.0,
                //           1.0,
                //         ),
                //         blurRadius: 0.5,
                //         spreadRadius: 0.5,
                //       ),
                //     ]
                // ),
                child: TextFormField(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.normal),
                  onTap: onTap,
                  enabled: enabled,
                  validator: validatior,
                  obscureText: obsecureText,
                  obscuringCharacter: '*',
                  controller: controller,
                  maxLength: length,
                  keyboardType: keyboardtype,
                  decoration: InputDecoration(
                      counterText: "",
                      suffixIcon:suffixIcons,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 3,
                      //     color: Colors.
                      //   )
                      // ),
                      hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).colorScheme.fontColor,
                        fontWeight: FontWeight.normal),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: colors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.lightWhite,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
