import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic>? booking;
  final Map<String, dynamic>? jsonData;
  final Map<String, dynamic>? ticket;
  final Map<String, dynamic>? detailsData;

  const Details(
      {Key? key, this.booking, this.jsonData, this.ticket, this.detailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List checkInsList = detailsData!['ticket']['check_ins'];
    List checkOutList = detailsData!['ticket']['check_outs'];
    List zoneList = detailsData!['zones'];

    final int? ticketTypeId =
        booking != null ? booking!['ticket_type'] as int? : null;
    final dynamic ticketType = ticketTypeId != null
        ? jsonData!['data']['ticket']['booking']['ticket_type']
        : null;
    final String ticketName = ticketType != null
        ? ticketType['ticket_name'] ?? ''
        : ticketTypeId.toString();

    //
    // final String tName = ticketType['ticket_name'];
    //
    final List<dynamic>? checkIns =
        ticket != null ? ticket!['check_ins'] as List<dynamic>? : null;
    final List<dynamic>? checkOuts =
        ticket != null ? ticket!['check_outs'] as List<dynamic>? : null;
    final List<dynamic>? zones =
        ticketType != null ? ticketType['zones'] as List<dynamic>? : null;

    final String name = booking != null ? booking!['name'] ?? '' : '';
    final String surname = booking != null ? booking!['surname'] ?? '' : '';
    final int? ticketId =
        booking != null ? booking!['ticket_id'] as int? : null;
    final String createdAt = booking != null && booking!['created_at'] != null
        ? DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(booking!['created_at']))
        : '';
    final List<String> checkInTimes = checkIns
            ?.map((checkIn) => checkIn['check_in_time'].toString())
            .toList() ??
        [];
    final List<String> checkOutTimes = checkOuts
            ?.map((checkOut) => checkOut['check_out_time'].toString())
            .toList() ??
        [];
    final List<String> zoneNames =
        zones?.map((zone) => zone['zone_name'].toString()).toList() ?? ['-'];
    final String email = booking != null ? booking!['email'] ?? '' : '';
    final String mobile = booking != null ? booking!['mobile'] ?? '' : '';
    final String comment = booking != null ? booking!['comment'] ?? '' : '';
    final String typeticket = booking != null ? booking!['type'] ?? '' : '';
    if (booking != null && booking!.containsKey('ticket_type')) {
      print(
          'NNNNNNNNNNNN: ${booking?['ticket_type']['price']} + $ticketId + $ticketType + $ticketTypeId');
    } else {
      print("NOOOOO");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BÚSQUEDA TICKET',
          style: TextStyle(),
        ),
        backgroundColor: const Color(0xFF002E3D),
      ),
      backgroundColor: const Color(0xFF24292E),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Text(
              '$name $surname',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7.h),
            Text(
              'ID: ${ticketId ?? ''}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              'Fecha: $createdAt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'Tipo de Ticket: $typeticket',
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ), // null
            SizedBox(height: 10.h),
            Text(
              'Check-Ins: ',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: checkInsList.length * 50,
              child: ListView.builder(
                itemCount: checkInsList.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Text(
                      checkInsList[index]['check_in_time'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ));
                },
              ),
            ),
            Text(
              'Check-Outs:',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: checkOutList.length * 50,
              child: ListView.builder(
                itemCount: checkOutList.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Text(
                      checkOutList[index]['check_out_time'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ));
                },
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Status: Válido',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              'Acceso:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: zoneList.length * 40,
              child: ListView.builder(
                itemCount: zoneList.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.all(1.0.h),
                    child: Text(
                      zoneList[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ));
                },
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Email: $email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Contacto: $mobile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Comentario: \n$comment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
