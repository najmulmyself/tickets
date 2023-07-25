import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pillatickets/View/scan.dart';
import 'package:pillatickets/View/selectscan.dart';
import 'package:pillatickets/View/ticket.dart';

import 'home.dart';
import 'logout.dart';

class SuccessPage extends StatelessWidget {
  final String name;
  final String surname;
  final String ticketId;
  final String zone;
  final String email;
  final String phone;
  final String createdAt;
  final bool isCheckout;
  final String comment;

  const SuccessPage({
    this.isCheckout = false,
    super.key,
    required this.name,
    required this.surname,
    required this.ticketId,
    required this.zone,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24292E),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 55.h,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF002E3D),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 65.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectScan(
                                        isCheckOut: isCheckout,
                                      )));
                        },
                        child: Image.asset(
                          'assets/images/backward.png',
                          width: 30.w,
                          height: 30.h,
                          fit: BoxFit.cover,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "ESCANEAR TICKET",
                        style: TextStyle(
                          color: const Color(0xFFF4F4F4),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Column Bar
            Container(
              height: MediaQuery.of(context).size.height,
              width: 70.w,
              color: const Color.fromRGBO(0, 0, 0, 0.15),
            ),

            //Column icons
            Positioned(
              top: 0.h,
              left: 10.w,
              child: SizedBox(
                height: 55.h,
                width: 50.w,
                child: Image.asset(
                  'assets/images/thunder.png',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Positioned(
              top: 70.h,
              left: 0.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home(
                                eventId: '',
                              )));
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/home.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Positioned(
              top: 160.h,
              left: 0.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scan(
                                eventId: '',
                              )));
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  color: const Color(0xFFB0C756),
                  child: Image.asset(
                    'assets/images/scan.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Positioned(
              top: 250.h,
              left: 0.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ticket(
                                eventId: '',
                              )));
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/ticket.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Positioned(
              top: 340.h,
              left: 0.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Logout(
                                eventId: '',
                                zoneId: '',
                              )));
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/logout.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 80.h,
              left: 90.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
                    width: 240.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CCD38),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150.h),
                              child: Icon(
                                Icons.check,
                                color: const Color(0xFF24292E),
                                size: 150.0.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      'Status: VÁLIDO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$name ',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        surname,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'ID: $ticketId',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(createdAt))}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      'Ticket: $zone',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/gmail.png',
                        width: 25.w,
                        height: 25.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/call.png',
                        width: 25.w,
                        height: 25.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        phone,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "comment",
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        comment,
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
