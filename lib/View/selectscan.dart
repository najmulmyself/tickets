import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillatickets/View/camera.dart';
import 'package:pillatickets/View/cameraout.dart';
import 'package:pillatickets/View/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/data.dart';
import 'package:http/http.dart' as http;

class SelectScan extends StatefulWidget {
  // final String eventId;
  late String selectedId;
  bool isCheckOut;

  SelectScan({super.key, this.isCheckOut = false});

  @override
  _SelectScanState createState() => _SelectScanState();
}

class _SelectScanState extends State<SelectScan> {
  late Future<List<Zone>> zonesFuture;
  String? SeventId;

  @override
  void initState() {
    super.initState();
    zonesFuture = getZones();
  }

  Future<List<Zone>> getZones() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        SeventId = prefs.getString('eventId');
      });
      print("S : $SeventId");
      var response = await http
          .get(Uri.https('pillatickets.com', 'api/get-zones/$SeventId'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Zone> zones = [];

        for (var eachZone in jsonData['data']['zones']) {
          final zone = Zone(
            zoneId: eachZone['id'],
            zoneName: eachZone['zone_name'],
          );
          zones.add(zone);
        }

        return zones;
      } else {
        throw Exception(
            'Failed to fetch zones. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch zones: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24292E),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scan(
                                  zoneId: '',
                                  eventId: SeventId!,
                                )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(18.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF557089),
                        borderRadius: BorderRadius.circular(12.h),
                      ),
                      child: Center(
                        child: InkWell(
                          child: Text(
                            "Go back to Scan",
                            style: TextStyle(
                              color: const Color(0xFFF4F4F4),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Container(
                    padding: EdgeInsets.all(18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF557089),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Center(
                      child: InkWell(
                        child: Text(
                          "ZONA",
                          style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                //events
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Container(
                    height: 380.h,
                    width: 300.w,
                    padding: EdgeInsets.all(15.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF323940),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<List<Zone>>(
                        future: zonesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            List<Zone> zones = snapshot.data ?? [];
                            return ListView.builder(
                              itemCount: zones.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(4.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF557089),
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        widget.isCheckOut == false
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QRScannerPage(
                                                    zoneName: zones[index]
                                                        .zoneName
                                                        .toString(),
                                                    zoneId: zones[index]
                                                        .zoneId
                                                        .toString(),
                                                    // eventId: widget.eventId,
                                                  ),
                                                ),
                                              )
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      QROutScannerPage(
                                                    isCheckout: true,
                                                    zoneName: zones[index]
                                                        .zoneName
                                                        .toString(),
                                                    zoneId: zones[index]
                                                        .zoneId
                                                        .toString(),
                                                    // eventId: widget.eventId,
                                                  ),
                                                ),
                                              );
                                      },
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            zones[index].zoneName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                //black lab
                Container(
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
                          fontSize: 12.h,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "BLACK LAB",
                        style: TextStyle(
                          color: const Color(0xFFF4F4F4),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.h,
                          fontFamily: 'Poppins',
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
