import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'session_manager.dart'; // Import the session manager
import 'login_page.dart'; // Import login page
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
  List<String> airports = [];
  String? selectedFromAirport;
  String? selectedToAirport;
  bool isLoading = false;
  List<Flight> flights = [];

  @override
  void initState() {
    super.initState();
    fetchAirports();
    checkSession(); // Check for an existing session
  }

  Future<void> checkSession() async {
    String? username = await SessionManager.getUser();
    if (username == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Future<void> fetchAirports() async {
    final String apiUrl = 'http://192.168.1.63:8000/api/flights/flights';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        Set<String> airportSet = Set<String>(); // Using a Set to avoid duplicate entries

        // Extract Arrival_Airport and Departure_Airport from each flight entry
        for (var flight in jsonData) {
          airportSet.add(flight['Arrival_Airport'].toString());
          airportSet.add(flight['Departure_Airport'].toString());
        }

        setState(() {
          airports = airportSet.toList();
        });
      } else {
        throw Exception('Failed to load airports');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> searchFlights() async {
    if (selectedFromAirport == null || selectedToAirport == null) {
      // Show an error dialog if either airport is not selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please select both departure and arrival airports.'),
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

    final String apiUrl = 'http://192.168.1.63:8000/api/flights/filter_flights';
    final Uri uri = Uri.parse('$apiUrl?from=$selectedFromAirport&to=$selectedToAirport');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = json.decode(response.body);
        setState(() {
          flights = List<Flight>.from(jsonData['flights'].map((x) => Flight.fromJson(x)));
          isLoading = false;
        });

        // Automatically navigate to SeatBookingPage with the first available flight
        if (flights.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeatBookingPage(
                flight: flights[0], // Pass the first available flight
              ),
            ),
          );
        }
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
              onTap: () async {
                await SessionManager.clearUser(); // Clear the session
                Navigator.pushReplacement(
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
                      items: airports.map((String airport) {
                        return DropdownMenuItem<String>(
                          value: airport,
                          child: Text(airport),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFromAirport = newValue;
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
                      items: airports.map((String airport) {
                        return DropdownMenuItem<String>(
                          value: airport,
                          child: Text(airport),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedToAirport = newValue;
                        });
                      },
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
                              '${flight.flightNumber} - ${flight.departureAirport} to ${flight.arrivalAirport}\n${flight.departureTime} to ${flight.arrivalTime}',
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
