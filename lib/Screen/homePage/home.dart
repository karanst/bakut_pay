import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/routes.dart';
import 'package:eshop_multivendor/Model/newmodels/get_services_model.dart';
import 'package:eshop_multivendor/Model/newmodels/getbannermodel.dart';
import 'package:eshop_multivendor/Screen/My%20Wallet/My_Wallet.dart';
import 'package:eshop_multivendor/Screen/Profile/MyProfile.dart';
import 'package:eshop_multivendor/Screen/RechargeModule/MyWallet.dart';
import 'package:eshop_multivendor/Screen/RechargeModule/add_money.dart';
import 'package:eshop_multivendor/Screen/RechargeModule/get_payment.dart';
import 'package:eshop_multivendor/Screen/RechargeModule/pay_send.dart';
import 'package:eshop_multivendor/Screen/RechargeModule/transactions_page.dart';
import 'package:eshop_multivendor/Screen/ReferAndEarn/ReferEarn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenRecharge extends StatefulWidget {
  @override
  _HomeScreenRechargeState createState() => _HomeScreenRechargeState();
}

class Payment {
  String image;
  String? title;
  Function onTap;
  Payment(this.image, this.title, this.onTap);
}

class _HomeScreenRechargeState extends State<HomeScreenRecharge> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  int currentindex = 0;

  ///API CALLS
  Getbannermodel? getbannermodel;
  getBanner() async {
    var headers = {
      'Cookie': 'ci_session=83721b31871c96522e60f489ca4e917362cdb60c'
    };
    var request = http.Request('GET', Uri.parse('$baseUrl/get_slider_images1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = Getbannermodel.fromJson(json.decode(finalResponse));
      print('aaaaaaaa>>>>>>>>>>>>>$jsonResponse');
      setState(() {
        getbannermodel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  // Userprofile? getprofile;

  // getuserProfile() async{
  //   print("This is user profile${username}");
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id  =  preferences.getString('id');
  //   username  =  preferences.getString('username');
  //   address =preferences.getString("address");
  //   var headers = {
  //     'Cookie': 'ci_session=7ff77755bd5ddabba34d18d1a5a3b7fbca686dfa'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_profile'));
  //   request.fields.addAll({
  //     'user_id': id.toString()
  //   });
  //   print("____________________${id}");
  //   print("request-----------__________${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //
  //   print("This is user request-----------${response.statusCode}");
  //
  //   if (response.statusCode == 200) {
  //     var finalResult = await response.stream.bytesToString();
  //     final jsonResponse = Userprofile.fromJson(json.decode(finalResult));
  //     print("this is final resultsssssssss${finalResult}");
  //     print("getuserdetails==============>${jsonResponse}");
  //     setState(() {
  //       getprofile = jsonResponse;
  //
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }
  List<Services> servicesList = [];
  // List<RechrgeModel>? RechrgeModelFromJson(String str) => List<RechrgeModel>.from(json.decode(str).map((x) => RechrgeModel.fromJson(x)));
  // String RechrgeModelToJson(List<RechrgeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  getServices() async {
    var headers = {
      'Cookie': 'ci_session=08b6c6afe557dc70d0ed3fb13b09bda9d8e3e0f2'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl/get_service'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalrespionse = await response.stream.bytesToString();
      final jsonresponse =
          GetServicesModel.fromJson(json.decode(finalrespionse));

      setState(() {
        servicesList = jsonresponse.data!;
      });
      print(' Rechargemodelllllllllllllllll${finalrespionse}');
      print('Succes>>>>>>>>>>>>>>>>>>>>>>>>>${jsonresponse}');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    // getuserProfile();
    getBanner();
    getServices();
  }

  Future<Null> _refresh() {
    return callAPI();
  }

  callAPI() {
    // getuserProfile();
    getBanner();
    getServices();
  }

  ///API CALLS

  String? username;
  String? address;

  @override
  void dispose() {
    super.dispose();
    // _anchoredBanner?.dispose();
  }

  List<Map<String, dynamic>> newsList = [
    {
      'image': 'assets/images/paysend.png',
      'title': 'Pay Or Send',
    },
    // {"image": "assets/imgs/wallet.png", "title": "My wallet",},
    {
      'image': 'assets/images/addmoney.png',
      'title': 'Add Money',
    },
    {
      'image': 'assets/images/transactions.png',
      'title': 'QR Code',
    },
    {
      'image': 'assets/images/transc.png',
      'title': 'Transaction',
    },
    // {"image": "assets/imgs/Editorial1.png", "title": "Editorial",},
    // {"image": "assets/imgs/Awareness inputs.png", "title": "Awareness Inputs",},
  ];
  List<Map<String, dynamic>> newsList2 = [
    {
      'image': 'assets/imgs/Recharge.png',
      'title': 'Recharge',
    },
    {
      'image': 'assets/imgs/Electricity.png',
      'title': 'Electricity',
    },
    {
      'image': 'assets/imgs/Water Bill.png',
      'title': ' Water Bill',
    },
    {
      'image': 'assets/imgs/Gas Bill.png',
      'title': 'Gas Bil',
    },
    {
      'image': 'assets/imgs/Recharge.png',
      'title': 'Dth',
    },
    {
      'image': 'assets/imgs/See all.png',
      'title': 'See all',
    },
    // {"image": "assets/imgs/Awareness inputs.png", "title": "Awareness Inputs",},
  ];
  @override
  Widget build(BuildContext context) {
    // print('${getprofile?.data?.isEmpty}__________');
    return Scaffold(
      key: _refreshIndicatorKey,
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      body: RefreshIndicator(
        color: colors.primary,
        onRefresh: () async {
          // _refresh();
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        // onRefresh: _refresh,
        child: SingleChildScrollView(
          child:
              // getprofile==null || getprofile?.data == ""? Center(child: CircularProgressIndicator(color: white,),):
              Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _RechargCard(),
              _CarouselSlider(),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).colorScheme.white,
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Transfer Money',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.fontColor,
                  ),
                ),
              ),
              Container(
                height: 140,
                color: Theme.of(context).colorScheme.white,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (c, index) {
                      return newsCard(index);
                    }),
              ),
              // const Padding(
              //   padding:  EdgeInsets.all(8.0),
              //   child: Text("Quick recharge & Bill Payment",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 15),),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 15, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Routes.navigateToMyWalletScreen(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              height:
                                  MediaQuery.of(context).size.width / 3 - 40,
                              width: MediaQuery.of(context).size.width / 3 - 40,
                              decoration: BoxDecoration(
                                  // image: const DecorationImage(
                                  //   scale: 0.5,
                                  //   image: AssetImage('assets/images/wallet.png'),
                                  //   fit: BoxFit.contain
                                  // ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: colors.primary.withOpacity(0.5)),
                              child: ImageIcon(
                                const AssetImage('assets/images/wallet.png'),
                                color: colors.whiteTemp,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'MY WALLET',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.width / 3 - 40,
                          width: MediaQuery.of(context).size.width / 3 - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colors.primary.withOpacity(0.5)),
                          child: ImageIcon(
                            const AssetImage('assets/images/coupon.png'),
                            color: colors.whiteTemp,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'COUPONS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReferEarn()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.width / 3 - 40,
                            width: MediaQuery.of(context).size.width / 3 - 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colors.primary.withOpacity(0.5)),
                            child: const ImageIcon(
                              AssetImage('assets/images/refer.png'),
                              color: colors.whiteTemp,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'REFER & EARN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // _RechargCard2(),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).colorScheme.white,
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Recharge & Pay Bills',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.fontColor,
                  ),
                ),
              ),
              servicesList == null || servicesList == ''
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: colors.primary,
                      ),
                    )
                  : Container(
                      height: 150,
                      color: Theme.of(context).colorScheme.white,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: servicesList.length,
                          itemBuilder: (c, index) {
                            return servicesCard(index);
                          }),
                    ),

              // CarouselSlider(
              //   options: CarouselOptions(
              //       viewportFraction: 1.0,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       autoPlayAnimationDuration:
              //       Duration(milliseconds: 150),
              //       enlargeCenterPage: false,
              //       scrollDirection: Axis.horizontal,
              //       height: 150.0),
              //   items: [1,2,3,4,5].map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: EdgeInsets.symmetric(horizontal: 5.0,),
              //           child: ClipRRect(
              //               borderRadius: BorderRadius.circular(20),
              //               child:
              //               Image.asset("assets/imgs/home banner.png",)
              //             // Image.network(
              //             //   "${getbannermodel.data![0].image}",
              //             //   fit: BoxFit.fill,
              //             // )
              //           ),
              //         );
              //       },
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  newsCard(int i) {
    return InkWell(
      onTap: () {
        if (i == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => ScanQRPage()));
        } else if (i == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => AddMoneyUI()));
        } else if (i == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => GetPaymentPage()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => TransactionPage()));
        }
      },
      child: Container(
        color: Theme.of(context).colorScheme.white,
        // decoration: BoxDecoration(
        //   color: colors.whiteTemp,
        //   borderRadius: BorderRadius.circular(15),
        //   border: Border.all(
        //     color: colors.black54
        //   )
        // ),
        //  height: 150,
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.all(10.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //     color: colors.black54
                      // )
                    ),
                    height: 60,
                    width: 60,
                    child: Image.asset('${newsList[i]['image']}', height: 45))),
            SizedBox(
              height: 5,
            ),
            Text(
              "${newsList[i]['title']}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }

  servicesCard( int i) {
    return InkWell(
      onTap: () {
        // if (i == 0) {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (C) => ScanQRPage()));
        // } else if (i == 1) {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (C) => MyWallet()));
        // } else if (i == 2) {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (C) => AddMoneyUI()));
        // } else if (i == 3) {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (C) => GetPaymentPage()));
        // } else {
        //   // Navigator.push(
        //   //     context, MaterialPageRoute(builder: (C) => TransactionPage()));
        // }
      },
      child: Container(
        color: Theme.of(context).colorScheme.white,
        // decoration: BoxDecoration(
        //   color: colors.whiteTemp,
        //   borderRadius: BorderRadius.circular(15),
        //   border: Border.all(
        //     color: colors.black54
        //   )
        // ),
        height: 150,
        width: 100,
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.all(10.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: colors.black54)),
                    height: 80,
                    width: 80,
                    child: Image.network(servicesList[i].image.toString(), height: 45))),
            const SizedBox(
              height: 5,
            ),
            Text(
              servicesList[i].name.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  color: colors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }


  _CarouselSlider() {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 10),
      child: getbannermodel == null || getbannermodel == ''
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 150),
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                height: 130,
                onPageChanged: (position, reason) {
                  setState(() {
                    currentindex = position;
                  });
                  print(reason);
                  print(CarouselPageChangedReason.controller);
                },
              ),
              items: getbannermodel?.data?.map((val) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  // height: 180,
                  // width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        '${val.image}',
                        fit: BoxFit.fill,
                      )),
                );
              }).toList(),
            ),
    );
  }
}
