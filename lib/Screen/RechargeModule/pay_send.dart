
import 'dart:io';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {

  // String _scanBarcode = 'Unknown';
  //
  // @override
  // Future<void> startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //       '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
  //       .listen((barcode) => print(barcode));
  // }

//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
// //barcode scanner flutter ant
//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }
//
//   Future<void> scanBarcodeNormal() async {
//     String barcodeScanResult;
//     try {
//       barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//       print(barcodeScanResult);
//     } on PlatformException {
//       barcodeScanResult = 'Failed to get platform version.';
//     }
//     if (!mounted) return;
//
//     setState(() {
//       _scanBarcode = barcodeScanResult;
//     });
//   }
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text("Pay Or Send"),
        iconTheme: IconThemeData(color: colors.whiteTemp),
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
          child: Text("Pay Or Send",
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
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.vertical -
                AppBar().preferredSize.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 14),
                  child: TextField(

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter Phone Number",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.grey, fontSize: 22),
                        suffixIcon:Icon(
                          Icons.perm_contact_calendar_rounded,
                          color: Theme.of(context).primaryColorLight,
                        )
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 14.0),
                      //   child: GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushNamed(
                      //             context, PageRoutes.enterPromoCodePage);
                      //       },
                      //       child: Text(
                      //         "",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .subtitle1!
                      //             .copyWith(
                      //             color: Theme.of(context)
                      //                 .primaryColorLight),
                      //       )
                      //   ),
                      // ),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width: 300,
                  //MediaQuery.of(context).size.width- 60,
                  height: 300,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                const SizedBox(height: 30,),
                Center(
                  child: (result != null)
                      ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                      : Text('Scan a QR', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),),
                ),

                // Container(
                //     alignment: Alignment.center,
                //     child: Column(
                //         // direction: Axis.vertical,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Container(
                //             width: MediaQuery.of(context).size.width- 60,
                //             height: 300,
                //             child: QRView(
                //               key: qrKey,
                //               onQRViewCreated: _onQRViewCreated,
                //             ),
                //           ),
                //           Expanded(
                //             flex: 1,
                //             child: Center(
                //               child: (result != null)
                //                   ? Text(
                //                   'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                //                   : Text('Scan a code'),
                //             ),
                //           )
                //           // ElevatedButton(
                //           //     onPressed: () => scanBarcodeNormal(),
                //           //     child: const Text('Barcode scan')),
                //           // InkWell(
                //           //   onTap:(){
                //           //     _onQRViewCreated(controller!);
                //           //   },
                //           //   child: Container(
                //           //     height: 40,
                //           //     width: 100,
                //           //     decoration: BoxDecoration(color: colors.primary,borderRadius: BorderRadius.circular(10)),
                //           //     child: Center(child:const Text("QR scan",style: TextStyle(color: Colors.white,fontSize: 20),)),
                //           //   ),
                //           // ),
                //           // ElevatedButton(
                //           //     onPressed: () => scanQR(),
                //           //     child: const Text('QR scan')),
                //           // ElevatedButton(
                //           //     onPressed: () => startBarcodeScanStream(),
                //           //     child: const Text('Barcode scan stream')),
                //           // Text('Scan result : $_scanBarcode\n',
                //           //     style: const TextStyle(fontSize: 20))
                //         ])),
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 14.0, vertical: 14),
                //       child: TextField(
                //
                //         keyboardType: TextInputType.number,
                //         decoration: InputDecoration(
                //           hintText: locale.enterPhoneNumber,
                //           hintStyle: Theme.of(context)
                //               .textTheme
                //               .headline5!
                //               .copyWith(color: hintColor, fontSize: 22),
                //           suffixIcon:Icon(
                //             Icons.perm_contact_calendar_rounded,
                //             color: Theme.of(context).primaryColorLight,
                //           )
                //           // Padding(
                //           //   padding: const EdgeInsets.symmetric(vertical: 14.0),
                //           //   child: GestureDetector(
                //           //       onTap: () {
                //           //         Navigator.pushNamed(
                //           //             context, PageRoutes.enterPromoCodePage);
                //           //       },
                //           //       child: Text(
                //           //         "",
                //           //         style: Theme.of(context)
                //           //             .textTheme
                //           //             .subtitle1!
                //           //             .copyWith(
                //           //             color: Theme.of(context)
                //           //                 .primaryColorLight),
                //           //       )
                //           //   ),
                //           // ),
                //         ),
                //       ),
                //     ),
                //     // Padding(
                //     //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                //     //   child: EntryField(
                //     //       locale.enterPhoneNumber,
                //     //       Icon(
                //     //         Icons.perm_contact_calendar_rounded,
                //     //         color: Theme.of(context).primaryColorLight,
                //     //       )),
                //     // ),
                //     SizedBox(height: 24),
                //     Expanded(
                //       child: Image.asset(
                //         'assets/imgs/Layer 1347.png',
                //         width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //     // Expanded(
                //     //   child: GestureDetector(
                //     //     onTap: () => Navigator.pushNamed(
                //     //         context, PageRoutes.paymentSuccessfulPage),
                //     //     child: Image.asset(
                //     //       'assets/imgs/Layer 1347.png',
                //     //       fit: BoxFit.cover,
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
                // Column(
                //   children: [
                //     SizedBox(height: 112),
                //     Text(
                //       locale.scanQrCode!,
                //       style: Theme.of(context).textTheme.bodyText1,
                //     ),
                //     Spacer(),
                //     Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         Image.asset(
                //           'assets/icons/qr code scanner.png',
                //           scale: 3.5,
                //         ),
                //         Container(
                //           width: MediaQuery.of(context).size.width / 1.4,
                //           height: 2,
                //           color: Theme.of(context).primaryColorLight,
                //         ),
                //       ],
                //     ),
                //     Spacer(),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         // IconButton(
                //         //     icon: Icon(
                //         //       Icons.flash_off,
                //         //       color: scaffoldBackgroundColor,
                //         //     ),
                //         //     onPressed: () {}),
                //         // IconButton(
                //         //     icon: Icon(
                //         //       Icons.photo,
                //         //       color: scaffoldBackgroundColor,
                //         //     ),
                //         //     onPressed: () {}),
                //       ],
                //     ),
                //     SizedBox(height: 36),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      //   beginOffset: Offset(0, 0.3),
      //   endOffset: Offset(0, 0),
      //   slideCurve: Curves.linearToEaseOut,
      // ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
      //       child: EntryField(
      //           'Enter Phone Number',
      //           Icon(
      //             Icons.perm_contact_calendar_rounded,
      //             color: Theme.of(context).primaryColorLight,
      //           )),
      //     ),
      //     SizedBox(height: 24),
      //     GestureDetector(
      //       onTap: () =>
      //           Navigator.pushNamed(context, PageRoutes.paymentSuccessfulPage),
      //       child: Stack(
      //         alignment: Alignment.center,
      //         children: [
      //           Image.asset(
      //             'assets/imgs/Layer 1347.png',
      //             width: MediaQuery.of(context).size.width,
      //             fit: BoxFit.fill,
      //           ),
      //           Stack(
      //             alignment: Alignment.center,
      //             children: [

      //             ],
      //           ),
      //           Positioned.directional(
      //               top: 40,
      //               textDirection: Directionality.of(context),
      //               child:

      //           Positioned.directional(
      //               textDirection: Directionality.of(context),
      //               bottom: MediaQuery.of(context).size.height / 4,
      //               child:

      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
