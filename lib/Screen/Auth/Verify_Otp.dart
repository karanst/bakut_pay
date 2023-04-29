import 'dart:async';
import 'dart:convert';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Model/newmodels/verify_otp_model.dart';
import 'package:eshop_multivendor/Provider/SettingProvider.dart';
import 'package:eshop_multivendor/Provider/UserProvider.dart';
import 'package:eshop_multivendor/Screen/Auth/Set_Password.dart';
import 'package:eshop_multivendor/Screen/Auth/SignUp.dart';
import 'package:eshop_multivendor/Screen/Dashboard/Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../widgets/ButtonDesing.dart';
import '../../widgets/desing.dart';
import '../../widgets/snackbar.dart';
import '../Language/languageSettings.dart';
import '../../widgets/networkAvailablity.dart';
import 'package:http/http.dart' as http;
class VerifyOtp extends StatefulWidget {
  final String? mobileNumber, countryCode, title, otp;

  const VerifyOtp(
      {Key? key,
      required String this.mobileNumber,
      this.countryCode,
      this.title, this.otp})
      : super(key: key);

  @override
  _MobileOTPState createState() => _MobileOTPState();
}

class _MobileOTPState extends State<VerifyOtp> with TickerProviderStateMixin {
  final dataKey = GlobalKey();
  String? password;
  String? otp;
  bool isCodeSent = false;
  late String _verificationId;
  String signature = '';
  bool _isClickable = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  String? name,
      email,
      mobile,
      id,
  upiId, qrCode;
  @override
  void initState() {
    super.initState();
    getUserDetails();
    getSingature();
    _onVerifyCode();
    Future.delayed(const Duration(seconds: 60)).then(
      (_) {
        _isClickable = true;
      },
    );
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  Future<void> getSingature() async {
    signature = await SmsAutoFill().getAppSignature;
    SmsAutoFill().listenForCode;
  }

  getUserDetails() async {
    if (mounted) setState(() {});
  }

  Future<void> checkNetworkOtp() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      if (_isClickable) {
        _onVerifyCode();
      } else {
        setSnackbar(getTranslated(context, 'OTPWR')!, context);
      }
    } else {
      if (mounted) setState(() {});

      Future.delayed(const Duration(seconds: 60)).then(
        (_) async {
          isNetworkAvail = await isNetworkAvailable();
          if (isNetworkAvail) {
            if (_isClickable) {
              _onVerifyCode();
            } else {
              setSnackbar(getTranslated(context, 'OTPWR')!, context);
            }
          } else {
            await buttonController!.reverse();
            setSnackbar(getTranslated(context, 'somethingMSg')!, context);
          }
        },
      );
    }
  }

  Widget verifyBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: AppBtn(
          title: getTranslated(context, 'VERIFY_AND_PROCEED'),
          btnAnim: buttonSqueezeanimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {
            if(otp!.isNotEmpty && otp!.length >= 4){
              verifyOtp();
            }else{
              setSnackbar("Please enter OTP", context);
            }

            // _onFormSubmitted();
          },
        ),
      ),
    );
  }

  void _onVerifyCode() async {
    if (mounted) {
      setState(
        () {
          isCodeSent = true;
        },
      );
    }
    PhoneVerificationCompleted verificationCompleted() {
      return (AuthCredential phoneAuthCredential) {
        _firebaseAuth.signInWithCredential(phoneAuthCredential).then(
          (UserCredential value) {
            if (value.user != null) {
              SettingProvider settingsProvider =
                  Provider.of<SettingProvider>(context, listen: false);

              setSnackbar(getTranslated(context, 'OTPMSG')!, context);
              settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
              settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
              if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
                Future.delayed(const Duration(seconds: 2)).then((_) {
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => const SignUp()));
                });
              } else if (widget.title ==
                  getTranslated(context, 'FORGOT_PASS_TITLE')) {
                Future.delayed(const Duration(seconds: 2)).then(
                  (_) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SetPass(
                          mobileNumber: widget.mobileNumber!,
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              setSnackbar(getTranslated(context, 'OTPERROR')!, context);
            }
          },
        ).catchError(
          (error) {
            setSnackbar(error.toString(), context);
          },
        );
      };
    }

    PhoneVerificationFailed verificationFailed() {
      return (FirebaseAuthException authException) {
        if (mounted) {
          setState(
            () {
              isCodeSent = false;
            },
          );
        }
      };
    }

    PhoneCodeSent codeSent() {
      return (String verificationId, [int? forceResendingToken]) async {
        _verificationId = verificationId;
        if (mounted) {
          setState(
            () {
              _verificationId = verificationId;
            },
          );
        }
      };
    }

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout() {
      return (String verificationId) {
        _verificationId = verificationId;
        if (mounted) {
          setState(
            () {
              _isClickable = true;
              _verificationId = verificationId;
            },
          );
        }
      };
    }

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${widget.countryCode}${widget.mobileNumber}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted(),
      verificationFailed: verificationFailed(),
      codeSent: codeSent(),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout(),
    );
  }
  verifyOtp()async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    // String? type = prefs.getString(TokenString.userType);
    // print("kkkkk ${type}");
    var headers = {
      'Cookie': 'ci_session=25ff5e4d1c8952f258520edbe7b2b7ec8703cfa9'
    };
    var request = http.MultipartRequest('POST', Uri.parse(verifyOtpApi.toString()));
    request.fields.addAll({
      'mobile': '${widget.mobileNumber}',
      'otp': otp.toString()
      //widget.otp.toString()
      //newOtp == null || newOtp == "" ? '${enteredOtp.toString()}': newOtp.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final value = json.decode(finalResponse);
      // print("final json response ${jsonResponse}");

      final jsonResponse = VerifyOtpModel.fromJson(json.decode(finalResponse));
      print("this is response code ${jsonResponse.message}");
      if(jsonResponse.error!){
        var i = value['data'][0];

   setState(() {
     id = i[ID];
     name = i[USERNAME];
     email = i[EMAIL];
     mobile = i[MOBILE];
     upiId = i['upi_id'];
     qrCode = i['qrcode'];
     CUR_USERID = id;
   });
        UserProvider userProvider = context.read<UserProvider>();
        userProvider.setName(name ?? '');
        SettingProvider settingProvider = context.read<SettingProvider>();
        settingProvider.saveUserDetail(id!, name, email, mobile, '',
            '', '', '', '', '', '', context);

        settingProvider.setPrefrenceBool(ISFIRSTTIME, true);
        // id = jsonResponse.data![0].id;
        // name = jsonResponse.data![0].username;
        // email = jsonResponse.data![0].email;
        // mobile = jsonResponse.data![0].mobile;
        // upiId = jsonResponse.data![0].upiId;
        // qrCode = jsonResponse.data![0].qrcode;
        // CUR_USERID = id;
        // UserProvider userProvider = context.read<UserProvider>();
        // userProvider.setName(name ?? '');
        // SettingProvider settingProvider = context.read<SettingProvider>();
        // settingProvider.saveUserDetail(id!, name, email, mobile, '',
        //     '', '', '', '', '', '', context);
        setSnackbar(jsonResponse.message.toString(), context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dashboard()));
      }else{
        setSnackbar(jsonResponse.message.toString(), context);
      }
      // if(jsonResponse.responseCode == "1") {
      //   setState(() {
      //     loading = false;
      //   });
      //   String userid = jsonResponse.userId!.id.toString();
      //   String userName = jsonResponse.userId!.username.toString();
      //   String mobile = jsonResponse.userId!.mobile.toString();
      //   String email = jsonResponse.userId!.email.toString();
      //   String userProfile = jsonResponse.userId!.profilePic.toString();
      //   String isGroupJoined = jsonResponse.userId!.groupId.toString();
      //   print("this is group joined response $isGroupJoined");
      //
      //   await prefs.setString(TokenString.userid, userid);
      //   await prefs.setString(TokenString.userName, userName);
      //   await prefs.setString(TokenString.userMobile, mobile);
      //   await prefs.setString(TokenString.userEmail, email);
      //   await prefs.setString(TokenString.userProfile, userProfile);
      //   await prefs.setString(TokenString.groupJoined, isGroupJoined);
      //
      //   showSnackbar("${jsonResponse.message.toString()}", context);
      //   if(isGroupJoined == "0"){
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      //         SearchScreen()));
      //   }else {
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      //         BottomBar(groupJoined: isGroupJoined.toString(),)));
      //   }
      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const MobileScreenLayout()));
      // }
      // else{
      //   setState(() {
      //     loading = false;
      //   });
      //   var snackBar = SnackBar(
      //     content: Text(jsonResponse.message.toString()),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void _onFormSubmitted() async {
    String code = otp!.trim();

    if (code.length == 6) {
      _playAnimation();
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code);

      _firebaseAuth
          .signInWithCredential(authCredential)
          .then((UserCredential value) async {
        if (value.user != null) {
          SettingProvider settingsProvider =
              Provider.of<SettingProvider>(context, listen: false);

          await buttonController!.reverse();
          setSnackbar(getTranslated(context, 'OTPMSG')!, context);
          settingsProvider.setPrefrence(MOBILE, widget.mobileNumber!);
          settingsProvider.setPrefrence(COUNTRY_CODE, widget.countryCode!);
          if (widget.title == getTranslated(context, 'SEND_OTP_TITLE')) {
            Future.delayed(const Duration(seconds: 2)).then((_) {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const SignUp()));
            });
          } else if (widget.title ==
              getTranslated(context, 'FORGOT_PASS_TITLE')) {
            Future.delayed(const Duration(seconds: 2)).then(
              (_) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SetPass(
                      mobileNumber: widget.mobileNumber!,
                    ),
                  ),
                );
              },
            );
          }
        } else {
          setSnackbar(getTranslated(context, 'OTPERROR')!, context);
          await buttonController!.reverse();
        }
      }).catchError((error) async {
        setSnackbar(getTranslated(context, 'WRONGOTP')!, context);

        await buttonController!.reverse();
      });
    } else {
      setSnackbar(getTranslated(context, 'ENTEROTP')!, context);
    }
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  monoVarifyText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 60.0,
      ),
      child: Text(
        getTranslated(context, 'MOBILE_NUMBER_VARIFICATION')!,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).colorScheme.fontColor,
              fontWeight: FontWeight.bold,
              fontSize: textFontSize23,
              letterSpacing: 0.8,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }

  otpText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: Text(
        getTranslated(context, 'SENT_VERIFY_CODE_TO_NO_LBL')!,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }

  mobText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5.0),
      child: Text(
        '+${widget.countryCode}-${widget.mobileNumber}',
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontFamily: 'ubuntu',
            ),
      ),
    );
  }

  Widget otpLayout() {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60, top: 30),
      child: PinFieldAutoFill(
        decoration: BoxLooseDecoration(

            textStyle: TextStyle(
                fontSize: textFontSize20,
                color: Theme.of(context).colorScheme.fontColor),
            radius: const Radius.circular(circularBorderRadius4),
            gapSpace: 15,
            bgColorBuilder: FixedColorBuilder(
                Theme.of(context).colorScheme.white.withOpacity(0.4)),
            strokeColorBuilder: FixedColorBuilder(
                Theme.of(context).colorScheme.fontColor.withOpacity(0.2))),
        currentCode: otp,
        codeLength: 4,
        onCodeChanged: (String? code) {
          otp = code;
        },
        onCodeSubmitted: (String code) {
          otp = code;
        },
      ),
    );
  }

  Widget resendText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restart_alt, color: colors.primary, size: 12,),
              TextButton(
                onPressed: (){},
                child: Text(
                  "Resend Code",
                  // getTranslated(context, 'DIDNT_GET_THE_CODE')!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    color:
                    Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntu',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, color: colors.primary, size: 12,),
              TextButton(
                onPressed: (){},
                child:
              Text(
                "Edit Number",
                // getTranslated(context, 'DIDNT_GET_THE_CODE')!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                  color:
                  Theme.of(context).colorScheme.fontColor.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ubuntu',
                ),
              ),
              ),
            ],
          ),
          // InkWell(
          //   onTap: () async {
          //     await buttonController!.reverse();
          //     checkNetworkOtp();
          //   },
          //   child: Text(
          //     getTranslated(context, 'RESEND_OTP')!,
          //     style: Theme.of(context).textTheme.caption!.copyWith(
          //           color: Theme.of(context).colorScheme.primary,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: 'ubuntu',
          //         ),
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            // top: 23,
            // left: 23,
            // right: 23,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getLogo(),
            verificationTitle(),
            enterCodeTitle(),
            // monoVarifyText(),
            // otpText(),
            // mobText(),
            otpLayout(),
            const SizedBox(height: 20,),
            Center(child: Text(widget.otp!, style: TextStyle(
              color: colors.primary, fontSize: 14,
              fontWeight: FontWeight.w600
            ),)),
            resendText(),
            verifyBtn(),
          ],
        ),
      ),
    );
  }
  Widget enterCodeTitle(){
    return Center(
      child: Text("Enter Code", style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14

      ),),
    );
  }
  Widget verificationTitle() {
    return const Center(
      child: Padding(
        padding:  EdgeInsetsDirectional.only(
            top: 30.0,
            bottom: 30
        ),
        child: Text("Verification Code",
            // widget.title == getTranslated(context, 'SEND_OTP_TITLE')
            //     ? getTranslated(context, 'SIGN_UP_LBL')!
            //     : getTranslated(context, 'FORGOT_PASSWORDTITILE')!,
            style: TextStyle(
                color: colors.primary,
                fontSize: 40,
                fontStyle: FontStyle.italic
            )
        ),
      ),
    );
  }
  Widget getLogo() {
    return Container(
      // height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))
        ),
        alignment: Alignment.center,
        // padding: const EdgeInsets.only(top: 60),
        child:
        Image.asset('assets/images/auth_image.png', fit: BoxFit.fill,)
    );
  }

  // Widget getLogo() {
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.only(top: 60),
  //     child: SvgPicture.asset(
  //       DesignConfiguration.setSvgPath('homelogo'),
  //       alignment: Alignment.center,
  //       height: 90,
  //       width: 90,
  //       fit: BoxFit.contain,
  //     ),
  //   );
  // }
}
