import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../admin/WelcomeScreen.dart';
import 'flight.dart';
import 'payment_page.dart';
import 'contactus_page.dart';

class SeatBookingPage extends StatelessWidget {
  final Flight flight;

  SeatBookingPage({required this.flight});

  // Define a method to fetch the available seats
  Future<List<dynamic>> fetchAvailableSeats() async {
    final String apiUrl = 'http://192.168.1.63:8000/api/flights/seats/${flight.id}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load seats');
    }
  }

  List<Widget> buildSeats(List<dynamic> seats) {
    return seats.map((seat) {
      Color seatColor = seat['status'] == 'available' ? Colors.green : Colors.red;
      return Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_seat,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(height: 4.0),
            Text(
              seat['number'],
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Booking'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF800000), // Maroon color
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_sharp),
              title: Text('LOG OUT'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchAvailableSeats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No seats available'));
          } else {
            final seats = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Available Seats for ${flight.airline} ${flight.flightNumber}',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1,
                      children: buildSeats(seats),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF800000), // Maroon button color
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentPage()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Booking confirmed!')),
                        );
                      },
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
