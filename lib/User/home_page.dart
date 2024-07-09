import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../admin/WelcomeScreen.dart';
import 'flight.dart';
import 'seatbooking_page.dart';
import 'payment_page.dart';
import 'contactus_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController departureDateController = TextEditingController();
  int adults = 1;
  int children = 0;
  List<String> cities = ['Kericho Airport', 'JKIA', 'City 3']; // Placeholder cities
  String? fromCity;
  String? toCity;
  bool isLoading = false;
  List<Flight> flights = [];

  Future<void> searchFlights() async {
    if (fromCity == null || toCity == null) {
      // Ensure both cities are selected before searching
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please select both departure and arrival cities.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final String apiUrl = 'http://192.168.1.63:8000/api/flights/flights';
    final Uri uri = Uri.parse('$apiUrl?from=$fromCity&to=$toCity&departureDate=${departureDateController.text}&adults=$adults&children=$children');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        setState(() {
          flights = list.map((model) => Flight.fromJson(model)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Flights'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF800000),
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
              leading: Icon(Icons.event_seat),
              title: Text('Seat Booking'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeatBookingPage()),
                );
              },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome ${widget.username}',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF800000), 
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Column(
                  children: [
                    ToggleButtons(
                      children: [Text('One Way'), Text('Round Trip')],
                      isSelected: [true, false],
                      onPressed: (int index) {
                        // Handle toggle button selection
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'From',
                        prefixIcon: Icon(Icons.flight_takeoff, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          fromCity = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'To',
                        prefixIcon: Icon(Icons.flight_land, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          toCity = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: departureDateController,
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            departureDateController.text =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Departure',
                        prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
                        searchFlights();
                      },
                      child: Text(
                        'Search Flights',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    if (isLoading)
                      Center(child: CircularProgressIndicator()),
                    if (flights.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: flights.length,
                        itemBuilder: (context, index) {
                          Flight flight = flights[index];
                          return ListTile(
                            title: Text(flight.airline),
                            subtitle: Text(
                              '${flight.flightNumber} - ${flight.departureTime} to ${flight.arrivalTime}',
                            ),
                            trailing: Text('\$${flight.price.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PassengerDropdown extends StatefulWidget {
  final int adults;
  final int children;
  final ValueChanged<Map<String, int>> onChanged;

  PassengerDropdown({
    required this.adults,
    required this.children,
    required this.onChanged,
  });

  @override
  _PassengerDropdownState createState() => _PassengerDropdownState();
}

class _PassengerDropdownState extends State<PassengerDropdown> {
  late int adults;
  late int children;

  @override
  void initState() {
    super.initState();
    adults = widget.adults;
    children = widget.children;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text('Adults'),
            DropdownButton<int>(
              value: adults,
              items: List.generate(10, (index) => index + 1)
                  .map((value) => DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  adults = value!;
                  widget.onChanged({'adults': adults, 'children': children});
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Text('Children'),
            DropdownButton<int>(
              value: children,
              items: List.generate(10, (index) => index)
                  .map((value) => DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  children = value!;
                  widget.onChanged({'adults': adults, 'children': children});
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
