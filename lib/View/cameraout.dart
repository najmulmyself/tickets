import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pillatickets/View/qrsuccess.dart';
import 'package:pillatickets/View/qrunsuccess.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QROutScannerPage extends StatefulWidget {
  final String zoneName;
  final String zoneId;
  final bool isCheckout;
  const QROutScannerPage(
      {super.key,
      required this.zoneName,
      required this.zoneId,
      required this.isCheckout});

  @override
  _QROutScannerPageState createState() => _QROutScannerPageState();
}

class _QROutScannerPageState extends State<QROutScannerPage> {
  final GlobalKey _globalKey = GlobalKey();

  QRViewController? controller;
  Barcode? result;

  String name = '';
  String surname = '';
  String email = '';
  String phone = '';
  String createdAt = '';
  String comment = '';

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        print('RESULT CODE:${result!.code}');
        if (result != null && result!.code != null) {
          checkTicketId(result!.code!);
          controller.pauseCamera();
          // controller.resumeCamera();
        }
      });
    });
  }

  Future<void> checkTicketId(String ticketId) async {
    try {
      final response = await http.post(
        Uri.parse('https://pillatickets.com/api/scan/checkout'),
        body: {
          'ticket_id': ticketId,
          'zone': widget.zoneName,
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        print("Entering try block and responsing");
        final bool isValid = decodedResponse['data']['status'] == 'valid';
        print("Entering valid block and responsing");
        if (isValid) {
          print("Entering name block and responsing");
          setState(() {
            name = decodedResponse['data']['ticket']['booking']['name'];
            surname = decodedResponse['data']['ticket']['booking']['surname'];
            email = decodedResponse['data']['ticket']['booking']['email'];
            phone = decodedResponse['data']['ticket']['booking']['mobile'];
            createdAt =
                decodedResponse['data']['ticket']['booking']['created_at'];
            comment = decodedResponse['data']['ticket']['booking']['comment'];
          });
          navigateToSuccessPage(name, surname, ticketId, widget.zoneName, email,
              phone, createdAt);
        } else {
          print("AAAA");
          navigateToFailurePage();
        }
      } else {
        print("BBBBBB");
        navigateToFailurePage();
      }
    } catch (e) {
      print('HH: $e');
      navigateToSuccessPage(
          name, surname, ticketId, widget.zoneName, email, phone, createdAt);
    }
  }

  void navigateToSuccessPage(String name, String surname, String ticketId,
      String zone, String email, String phone, String createdAt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessPage(
          isCheckout: true,
          name: name,
          surname: surname,
          ticketId: ticketId,
          zone: widget.zoneName,
          email: email,
          phone: phone,
          createdAt: createdAt,
          comment: comment,
        ),
      ),
    );
  }

  void navigateToFailurePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FailurePage(
          zoneId: widget.zoneId,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 4.0),
            ),
            child: QRView(
              key: _globalKey,
              onQRViewCreated: qr,
              overlay: QrScannerOverlayShape(
                borderRadius: 10.h,
                borderColor: const Color(0xFF557089),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0.h),
              child: Text(
                'Scan QR Code',
                style: TextStyle(fontSize: 20.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class SuccessPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args =
//     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Success')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Name: ${args['name']} ${args['surname']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'Ticket ID: ${args['ticketId']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'Created At: ${args['createdAt']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'Email: ${args['email']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'Mobile: ${args['mobile']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             Text(
//               'Type: ${args['type']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Zones:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: args['zones'].length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(args['zones'][index]),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FailurePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Failure')),
//       body: Center(
//         child: Text(
//           'Invalid QR Code',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
