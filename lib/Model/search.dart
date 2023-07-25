import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pillatickets/View/search_details.dart';

class TicketSearch extends StatefulWidget {
  const TicketSearch({Key? key}) : super(key: key);

  get jsonData => null;
  
  @override
  _TicketSearchState createState() => _TicketSearchState();
}

class _TicketSearchState extends State<TicketSearch> {
  List<dynamic> _tickets = [];
  bool _isLoading = false;

  Future<void> _fetchTickets(String searchText) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://pillatickets.com/api/search-ticket/$searchText');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> tickets = jsonData['data']['tickets'];
      final filteredTickets = tickets
          .where((ticket) =>
          ticket['id']
              .toString()
              .contains(searchText.toLowerCase()) ||
          ticket['booking']['name']
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          ticket['booking']['surname']
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          ticket['booking']['created_at']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();

      setState(() {
        _isLoading = false;
        _tickets = filteredTickets;
      });
    } else {
      setState(() {
        _isLoading = false;
        _tickets = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (text) {
                        _fetchTickets(text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
                : _tickets.isEmpty
                ? Center(
              child: Text(
                ' ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ListView.builder(
              itemCount: _tickets.length,
              itemBuilder: (context, index) {
                final ticket = _tickets[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 0.12),
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  margin: EdgeInsets.only(top: 10.h),
                  child: ListTile(
                    onTap: () async {
                      final detailsUrl = Uri.parse('http://pillatickets.com/api/ticket-info/${ticket['id']}');
                      final detailsResponse = await http.get(detailsUrl);

                      if (detailsResponse.statusCode == 200) {
                        final detailsData = jsonDecode(detailsResponse.body)['data'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              booking: ticket['booking'],
                              jsonData: widget.jsonData,
                              ticket: ticket,
                              detailsData: detailsData,
                            ),
                          ),
                        );
                      }
                    },

                    title: Text(
                      '${ticket['booking']['name']} ${ticket['booking']['surname']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${ticket['booking']['ticket_id']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          'Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(ticket['booking']['created_at']))}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
