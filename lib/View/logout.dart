import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillatickets/View/home.dart';
import 'package:pillatickets/View/login.dart';
import 'package:pillatickets/View/scan.dart';
import 'package:pillatickets/View/selection_page.dart';
import 'package:pillatickets/View/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  final String eventId;
  final String zoneId;
  const Logout({Key? key, required this.eventId, required this.zoneId})
      : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    // setState(() {
    //   userId = prefsId;
    // });
  }

  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24292E),
      body: SafeArea(
        child: Stack(
          children: [
            //App Bar
            Container(
              height: 55.h,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF002E3D),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "      PILLATICKETS",
                    style: TextStyle(
                        color: const Color(0xFFF4F4F4),
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
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
                          builder: (context) => Home(
                                eventId: widget.eventId,
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
                                zoneId: '',
                                eventId: '',
                              )));
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
              child: Container(
                height: 70.h,
                width: 70.w,
                color: const Color(0xFFB0C756),
                child: Image.asset(
                  'assets/images/logout.png',
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //Buttons
            Positioned(
              top: 70.h,
              left: 60.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionScreen(
                          userId: userId.toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.h,
                    width: 250.w,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF557089),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Center(
                      child: Text(
                        "Seleccionar evento",
                        style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 140.h,
              left: 60.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    height: 50.h,
                    width: 250.w,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF557089),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Center(
                      child: Text(
                        "Cerrar sesión",
                        style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //blacklab
            Positioned(
              top: 550.h,
              left: 125.w,
              child: Container(
                color: const Color(0xFF002E3D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Powered by ",
                      style: TextStyle(
                          color: const Color(0xFFF4F4F4),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      "BLACK LAB",
                      style: TextStyle(
                          color: const Color(0xFFF4F4F4),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins'),
                    ),
                    Image(
                      image: const AssetImage('assets/images/thunder.png'),
                      height: 22.h,
                      width: 16.w,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
