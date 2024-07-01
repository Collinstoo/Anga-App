import 'package:flutter/material.dart';
import 'package:flight_booking_application/payment_page.dart';

class SeatBookingPage extends StatelessWidget {
  final int totalSeats = 100;
  final int vipSeats = 15;
  final int premierSeats = 15;
  final int businessSeats = 20;
  final int economySeats = 50;

  List<Widget> buildSeats(int count, Color color, String label, int startNumber) {
    return List<Widget>.generate(
      count,
          (index) => Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.event_seat,
              color: color,
              size: 24.0,
            ),
            Text(
              '$label ${startNumber + index}',
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int seatNumber = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'VIP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: buildSeats(vipSeats, Colors.redAccent, 'VIP', seatNumber),
              ),
              SizedBox(height: 10),
              Text(
                'Premier',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.5,
                children: buildSeats(premierSeats, Colors.orangeAccent, 'Premier', seatNumber += vipSeats),
              ),
              SizedBox(height: 10),
              Text(
                'Business',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1,
                children: buildSeats(businessSeats, Colors.blueAccent, 'Business', seatNumber += premierSeats),
              ),
              SizedBox(height: 10),
              Text(
                'Economy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              GridView.count(
                crossAxisCount: 6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.75,
                children: buildSeats(economySeats, Colors.green, 'Economy', seatNumber += businessSeats),
              ),
              SizedBox(height: 20),
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
                    MaterialPageRoute(builder: (context) =>  PaymentPage()),
                  );
                  // Handle book action
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking confirmed!')),
                  );
                },
                child: Text(
                  'Check Available Seats',
                  style: TextStyle(
                    fontSize: 18.0,
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