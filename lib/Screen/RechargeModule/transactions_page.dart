import 'dart:convert';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/custom_button.dart';
import 'package:eshop_multivendor/Screen/Test/Widget/ListTile2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
   // Transactionhistorymodel? transactionhistory;

  // Transaction() async {
  //   var headers = {
  //     'Cookie': 'ci_session=08628db3954ee6abd539f30067f0d8ebc43c8a38'
  //   };
  //   var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/financego/app/v1/api/get_transactions'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var finalresponse = await response.stream.bytesToString();
  //     final jsonrespose = Transactionhistorymodel.fromJson(json.decode(finalresponse));
  //     setState(() {
  //       transactionhistory = jsonrespose;
  //     });
  //
  //     print('this is transaction historyyyyyyy___${jsonrespose}');
  //     print('this is transaction historyyyyyyy___${finalresponse}');
  //
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Transaction();
  }

  @override
  Widget build(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    String balance = "30";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.whiteTemp),
        title: Text(
          "Transaction History",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w700,color: colors.whiteTemp),
        ),
      ),
      body: 
      // transactionhistory == null || transactionhistory == "" ? Center(child: CircularProgressIndicator(),)
      ListView(
        // physics: BouncingScrollPhysics(),
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          // Text(
          //   "Your Balance",
          //   style: Theme.of(context).textTheme.bodyText2,
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(
          //   height: 4,
          // ),
          // Text('\₹' + balance.toString(),
          //     style: Theme.of(context)
          //         .textTheme
          //         .headline4!
          //         .copyWith(color: blackColor),
          //     textAlign: TextAlign.center),
          // SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 12,
          //     ),
          //     Expanded(
          //         child: CustomButton(
          //       locale.sendToBank,
          //       textColor: Theme.of(context).primaryColorLight,
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //     )),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     Expanded(child: CustomButton(locale.addMoney)),
          //     SizedBox(
          //       width: 12,
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 30,
          // ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              //transactionhistory?.data?.length  ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomHeading(
                      heading:   'January 2022',
                    ),
                    Card(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          //transactionhistory?.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    'assets/images/transactionhistory.png',
                                    scale: 2.5,
                                  ),
                                  title: Text("Pending"),
                                      //"${transactionhistory?.data?[index].message}"),
                            subtitle:
                            Text("20 Jan 2023",
                                    style: TextStyle(
                                        fontSize: 12, ),
                                  ),
                                  trailing: Text('- \₹ 10'
                                      '.50'),
                                ),
                                index != 2
                                    ? Divider(thickness: 6)
                                    : SizedBox.shrink(),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
