import 'package:flight_booking_application/User/payment_page.dart';
import 'package:flight_booking_application/User/seatbooking_page.dart';
import 'package:flight_booking_application/admin/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Ticketing_page.dart';
// import 'package:flight_booking_application/book_flight_page.dart';
// import 'package:flight_booking_application/ticketing_page.dart';

class ContactUsPage extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color(0xFF340404),
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
                color: Color(0xFF340404), // Adjust color as needed
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
              leading: Icon(Icons.flight),
              title: Text('Book Flight'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BookFlightPage()),
                // );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.event_seat),
            //   title: Text('Seat Booking'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SeatBookingPage()),
            //     );
            //   },
            // ),
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
              leading: Icon(Icons.airplane_ticket),
              title: Text('Ticketing'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketingPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event_seat),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF800000),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.email, color: Color(0xFF800000)),
                  title: Text('Email Us'),
                  subtitle: Text('info@flightbooking.com'),
                  onTap: () => _launchURL('mailto:info@flightbooking.com'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.phone, color: Color(0xFF800000)),
                  title: Text('Call Us'),
                  subtitle: Text('+1 234 567 890'),
                  onTap: () => _launchURL('tel:+1234567890'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.chat, color: Color(0xFF800000)),
                  title: Text('WhatsApp'),
                  subtitle: Text('+1 234 567 890'),
                  onTap: () => _launchURL('https://wa.me/1234567890'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.facebook, color: Color(0xFF800000)),
                  title: Text('Facebook'),
                  subtitle: Text('Follow us on Facebook'),
                  onTap: () => _launchURL('https://www.facebook.com/flightbooking'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.link, color: Color(0xFF800000)),
                  title: Text('Website'),
                  subtitle: Text('Visit our website'),
                  onTap: () => _launchURL('https://www.flightbooking.com'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Color(0xFF800000)),
                  title: Text('Our Address'),
                  subtitle: Text('123 Main Street, City, Country'),
                  onTap: () => _launchURL('https://maps.google.com/?q=123+Main+Street,+City,+Country'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'We are here to assist you 24/7',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
