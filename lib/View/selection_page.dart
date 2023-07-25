import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pillatickets/View/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/data.dart';
import 'package:http/http.dart' as http;

class SelectionScreen extends StatefulWidget {
  String? userId;
  SelectionScreen({
    super.key,
    this.userId,
  });

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String? eventTitle;
  late Future<List<Event>> eventsFuture;

  @override
  void initState() {
    super.initState();
    eventsFuture = getEvents();
  }

  Future<List<Event>> getEvents() async {
    var response = await http.get(Uri.https(
        'pillatickets.com', 'api/get-events/${widget.userId.toString()}'));
    var jsonData = jsonDecode(response.body);
    List<Event> events = [];

    for (var eachEvents in jsonData['data']['events']) {
      final event = Event(
        id: eachEvents['id'],
        title: eachEvents['title'],
        place: eachEvents['place'],
      );
      events.add(event);
    }
    return events;
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
                SizedBox(
                  height: 10.h,
                ),

                SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: Image.asset(
                    'assets/images/ICON APP.png',
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(
                  height: 15.h,
                ),

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
                          "Selecciona el evento",
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

                SizedBox(
                  height: 5.h,
                ),

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
                      child: FutureBuilder<List<Event>>(
                        future: eventsFuture,
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
                            List<Event> events = snapshot.data ?? [];
                            return ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(4.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF557089),
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            'eventTitle', events[index].title);
                                        print(events[index].id.toString());
                                        setState(() {
                                          eventTitle =
                                              prefs.getString('eventTitle');
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(
                                                // eventTitle: events[index].title,
                                                eventTitle: eventTitle,
                                                eventId: events[index]
                                                    .id
                                                    .toString()),
                                          ),
                                        ).then((_) {
                                          // When returning from Home screen, trigger data update
                                          setState(() {
                                            eventsFuture =
                                                getEvents(); // Fetch events again if needed
                                          });
                                        });
                                      },
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            events[index].title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        subtitle: Center(
                                          child: Text(
                                            events[index].place,
                                            style: const TextStyle(
                                                color: Colors.white),
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

                SizedBox(
                  height: 10.h,
                ),

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
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        "BLACK LAB",
                        style: TextStyle(
                            color: const Color(0xFFF4F4F4),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.h,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
