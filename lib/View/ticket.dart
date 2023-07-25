import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillatickets/View/home.dart';
import 'package:pillatickets/View/logout.dart';
import 'package:pillatickets/View/scan.dart';
import '../Model/search.dart';

class Ticket extends StatefulWidget {
  final String eventId;
  Ticket({Key? key, required this.eventId}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24292E),
      body: SafeArea(
        child: Stack(
          children: [
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
                    "         BÚSQUEDA TICKET ",
                    style: TextStyle(
                        color: Color(0xFFF4F4F4),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
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
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Scan(zoneId: '', eventId: '',)));
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  color: Colors.white,
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
              child: Container(
                height: 70.h,
                width: 70.w,
                color: Color(0xFFB0C756),
                child: Image.asset(
                  'assets/images/ticket.png',
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

            //search
            Positioned(
              top: 70.h,
              left: 80.w,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 270.w,
                child: TicketSearch(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

