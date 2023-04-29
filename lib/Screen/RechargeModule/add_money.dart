import 'dart:convert';

// import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/custom_button.dart';
import 'package:eshop_multivendor/Screen/Test/Widget/ListTile2.dart';
import 'package:eshop_multivendor/widgets/ButtonDesing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:quick_pay/Components/custom_button.dart';
// import 'package:quick_pay/Locale/locales.dart';
// import 'package:quick_pay/Routes/routes.dart';
// import 'package:quick_pay/Theme/colors.dart';
import 'package:http/http.dart'as http;
// import 'package:quick_pay/model/add_wallet_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddMoneyUI extends StatefulWidget {
  @override
  _AddMoneyUIState createState() => _AddMoneyUIState();
}

class _AddMoneyUIState extends State<AddMoneyUI> {
  final _formKey = GlobalKey<FormState>();

  // AddWalletModel? addWalletModel;

  TextEditingController _amountController = TextEditingController();

  // addWallet() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id = preferences.getString("id");
  //
  //   var headers = {
  //     'Cookie': 'ci_session=ec52faaf4141b7aee9f262fa0bdfee398ae84f13'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/financego/app/v1/api/add_money_wallet'));
  //   request.fields.addAll({
  //     'user_id': id.toString(),
  //     'amount': _amountController.text,
  //     'transaction_id': '120',
  //     'type': 'credit'
  //   });
  //
  //   print("This is user request>>>>>>>>>>>${request.fields}");
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //
  //
  //     var finalresponse = await response.stream.bytesToString();
  //     final jsonresponse = AddWalletModel.fromJson(jsonDecode(finalresponse));
  //
  //     setState(() {
  //       addWalletModel = jsonresponse;
  //     });
  //
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  // }

  @override
  // Getwalletmodel? walletData;

  // getWallet() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id = preferences.getString("id");
  //
  //   print('_________________>>>>>>>>>>>>>>>>>>>>>${id}');
  //   var headers = {
  //     'Cookie': 'ci_session=8c2275d8af8aa49a38366843cf03ea05190bd53b'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/financego/app/v1/api/get_wallet_transaction'));
  //   request.fields.addAll({
  //     'user_id': id.toString()
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var walletresult = await response.stream.bytesToString();
  //     final finalresponse = Getwalletmodel.fromJson(json.decode(walletresult));
  //     setState((){
  //       walletData = finalresponse;
  //     });
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getWallet();
  }
  int _choiceChipValue = 4; // INR initially

  final currencies = {
    '+100': '100',
    '+500': '500',
    '+800': '800',
    '+100': '100',
    '1000': '1000',
    '100000': '100000',
  };


  @override
  Widget build(BuildContext context) {

    // var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      appBar: AppBar(
        backgroundColor: colors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.whiteTemp),
        title: Text("Add Money",
          // locale.addMoney!,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700,color:colors.whiteTemp),
        ),
      ),
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            primary: colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            fixedSize: Size(MediaQuery.of(context).size.width, 50)
          ),
          child: Text("Add Money",
          style: TextStyle(

            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: colors.whiteTemp
          ),),
        ),
      ),
      body:
      // FadedSlideAnimation(
      //   child:
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                    height: 90,
                    width: 170,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: colors.whiteTemp, border: Border.all(color: colors.blackTemp)),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                            children:[
                              Text(
                                "Your Current Balance",
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              // walletData==null || walletData?.data?.first.amount == ""? Center(child: CircularProgressIndicator(color: primary,),):
                              Text('\₹' + "0",
                                  style: Theme.of(context).textTheme
                                      .headline4!
                                      .copyWith(color: colors.blackTemp),
                                  textAlign: TextAlign.center),
                            ]))),

                SizedBox(height: 20),

                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 25),
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Amount",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.grey, fontSize: 22),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, PageRoutes.enterPromoCodePage);
                                  },
                                  child: Text(
                                    "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  )
                              ),
                            ),
                          ),
                        ),
                        // InputField(
                        //   controller:_amountController,
                        //   label: 'Amount',
                        //   hintText: 'Enter amount',
                        //   inputType: TextInputType.number,
                        //   inputAction: TextInputAction.next,
                        //   leading: Text("",
                        //     // currencies.values.elementAt(_choiceChipValue),
                        //     style: const TextStyle(
                        //       color: Colors.pink,
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        //   // Allow only two decimals digits
                        //   textInputFormatter: FilteringTextInputFormatter.allow(
                        //     RegExp(r'^\d+\.?\d{0,2}'),
                        //   ),
                        //   validator: Validator.amount, textColor: colors.blackTemp, primaryColor: primary,
                        // ),
                        ),
                      Wrap(
                        runSpacing: 8,
                        children: List.generate(
                          currencies.length,
                              (index) => Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: ChoiceChip(
                              label: Text(currencies.keys.toList()[index]),
                              selected: _choiceChipValue == index,
                              backgroundColor: colors.primary,
                              // Palette.blueMedium.withOpacity(0.4),
                              // selectedColor: Palette.blueMedium,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              labelStyle: const TextStyle(
                                color: colors.whiteTemp,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.6,
                              ),
                              onSelected: (value) {
                                if (value) {
                                  setState(() => _choiceChipValue = index);
                                  print("aaaaaaaa${currencies}");
                                  print("aaaaaaaa${_choiceChipValue}");
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: CustomButton(
                      //       "Add Money",
                      //       onTap: () {
                      //         if (_formKey.currentState!.validate()) {
                      //           Razorpay razorpay = Razorpay();
                      //           var options = {
                      //             'key': 'rzp_test_1spO8LVd5ENWfO',
                      //             'amount': int.parse(_amountController.text)*100,
                      //             'name': 'Ankit .',
                      //             'description': 'Fine T-Shirt',
                      //             'retry': {'enabled': true, 'max_count': 1},
                      //             'send_sms_hash': true,
                      //             'prefill': {
                      //               'contact': '8888888888',
                      //               'email': 'test@razorpay.com'
                      //             },
                      //             'external': {
                      //               'wallets': ['paytm']
                      //             }
                      //           };
                      //           razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                      //               handlePaymentErrorResponse);
                      //           razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      //               handlePaymentSuccessResponse);
                      //           razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      //               handleExternalWalletSelected);
                      //           razorpay.open(options);
                      //         }
                      //       }
                      //   ),
                      // ),
                      // addWalletModel==null || addWalletModel?.data?.amount== ""? Center(child: CircularProgressIndicator(),):
                      // Text(
                      //   'Recharge Application ' + locale.balance! + ' \₹${addWalletModel?.data?.amount}' ?? "",
                      //   style: Theme.of(context).textTheme.subtitle1,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      //   beginOffset: Offset(0, 0.3),
      //   endOffset: Offset(0, 0),
      //   slideCurve: Curves.linearToEaseOut,
      // ),
    );

  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){

    // addWallet();

    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }
  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }


  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
