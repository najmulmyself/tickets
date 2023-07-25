import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillatickets/View/selectscan.dart';
import 'package:pillatickets/View/ticket.dart';
import 'home.dart';
import 'logout.dart';

class Scan extends StatelessWidget {
  final String eventId;
  final String? zoneId;

  Scan({required this.eventId, this.zoneId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24292E),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //App Bar
            Container(
              height: 55.h,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF002E3D),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "     ESCANEAR TICKET",
                    style: TextStyle(
                      color: Color(0xFFF4F4F4),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            //Column Bar
            Container(
              height: MediaQuery.of(context).size.height,
              width: 70.w,
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),

            //Column icons
            Positioned(
              top: 0.h,
              left: 10.w,
              child: Container(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home(eventId: '',)));
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
              child: Container(
                height: 70.h,
                width: 70.w,
                color: Color(0xFFB0C756),
                child: Image.asset(
                  'assets/images/scan.png',
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Ticket(eventId: '',)));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Logout(eventId: '', zoneId: '',)));
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

            //zone
            Positioned(
              top: 120.h,
              left: 90.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectScan(isCheckOut: false,)));
                },
                child: Container(
                  height: 45.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF7848F4),
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Center(
                    child: Text(
                      "Check-in Scan",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 180.h,
              left: 90.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectScan(isCheckOut: true,)));
                },
                child: Container(
                  height: 45.h,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF7848F4),
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Center(
                    child: Text(
                      "Check-out Scan",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
