import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'About Our Company',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Image.asset(
                'assets/company_logo.png', // Add your company logo image here
                height: 150.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Welcome to FlightBooking!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We are dedicated to making your travel experience as seamless and enjoyable as possible. With our app, you can book flights to various destinations, check flight statuses, and manage your bookings effortlessly.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our mission is to provide a user-friendly platform that simplifies the flight booking process, ensuring that you can book your travel plans with confidence and ease.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10.0),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.blueAccent),
                title: Text('Wide range of destinations'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.blueAccent),
                title: Text('Easy booking process'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.blueAccent),
                title: Text('Secure payment options'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.blueAccent),
                title: Text('24/7 customer support'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10.0),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.blueAccent),
                title: Text('Phone: +254 741 296266'),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.blueAccent),
                title: Text('Email: support@flightbooking.com'),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.blueAccent),
                title: Text('Address: 123 Main Street, Nairobi, Kenya'),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to home or another page
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}