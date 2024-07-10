import 'package:flight_booking_application/User/seatbooking_page.dart';
import 'package:flutter/material.dart';
import 'flight.dart';

class YourFlightPage extends StatelessWidget {
  final List flights;

  YourFlightPage({required this.flights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Flights'),
        backgroundColor: Colors.deepPurple, // Set app bar background color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade700], // Gradient for page background
          ),
        ),
        child: ListView.builder(
          itemCount: flights.length,
          itemBuilder: (context, index) {
            var flight = flights[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.deepPurple.shade800, // Set card background color
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${flight['departure_airport']} to ${flight['arrival_airport']}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Colors.deepPurpleAccent), // Airport text style
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${flight['departure_city']} to ${flight['arrival_city']}',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent, fontSize: 12.0), // City text style
                            ),
                            Text(
                              '\$${flight['price'].toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.deepPurpleAccent), // Price text style
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          'Departure: ${flight['departure_date_time']}',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.deepPurpleAccent), // Departure time text style
                        ),
                        Text(
                          'Arrival: ${flight['arrival_date_time']}',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.deepPurpleAccent), // Arrival time text style
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SeatBookingPage(flight: flight)),
                      // );
                      // Navigate to details page or perform action
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => FlightDetailsPage(flight: flight)));
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
