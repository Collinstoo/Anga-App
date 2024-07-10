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
import 'your_flight_page.dart'; // Import your custom YourFlightPage

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> cities = [];
  String? selectedFromCity;
  String? selectedToCity;
  bool isLoading = false;
  List flights = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
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

  Future<void> fetchCities() async {
    final String apiUrl = 'http://192.168.1.63:8000/api/flights/filter';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        Set<String> citySet = Set<String>(); // Using a Set to avoid duplicate entries

        // Extract cities from each flight entry
        for (var flight in jsonData) {
          citySet.add(flight['arrival_city'].toString());
          citySet.add(flight['departure_city'].toString());

        }

        setState(() {
          cities = citySet.toList();
        });
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> searchFlights() async {
    if (selectedFromCity == null || selectedToCity == null) {
      // Show an error dialog if either city is not selected
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

    final String apiUrl = 'http://192.168.1.63:8000/api/flights/filter';
    final Uri uri = Uri.parse('$apiUrl?from=$selectedFromCity&to=$selectedToCity');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        // List<Flight> fetchedFlights = [];

        // for (var flightJson in jsonData['flights']) {
        //   Flight flight = Flight(
        //     airplaneId: flightJson['airplane_id'],
        //     arrivalAirport: flightJson['arrival_airport'],
        //     arrivalAirportName: flightJson['arrival_airport_name'],
        //     arrivalCity: flightJson['arrival_city'],
        //     arrivalCountry: flightJson['arrival_country'],
        //     arrivalDateTime: DateTime.parse(flightJson['arrival_date_time']),
        //     capacity: flightJson['capacity'],
        //     departureAirport: flightJson['departure_airport'],
        //     departureAirportName: flightJson['departure_airport_name'],
        //     departureCity: flightJson['departure_city'],
        //     departureCountry: flightJson['departure_country'],
        //     departureDateTime: DateTime.parse(flightJson['departure_date_time']),
        //     flightId: flightJson['flight_id'],
        //     flightNumber: flightJson['flight_number'],
        //     price: flightJson['price'].toDouble(),
        //   );
        //
        //   fetchedFlights.add(flight);
        // }

        setState(() {
          flights = jsonData;
          // flights = fetchedFlights;
          isLoading = false;
        });

        // Navigate to YourFlightPage with filtered flights
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YourFlightPage(
              flights: flights,
            ),
          ),
        );
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
                      items: cities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedFromCity = newValue;
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
                          selectedToCity = newValue;
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      ),
                    // if (isLoading)
                    //   Center(child: CircularProgressIndicator()),
                    // if (flights.isNotEmpty)
                    //   Text('${flights}')
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: flights.length,
                      //   itemBuilder: (context, index) {
                      //     Flight flight = flights[index];
                      //     return ListTile(
                      //       title: Text(flight.flightNumber),
                      //       subtitle: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text('${flight.departureCity} to ${flight.arrivalCity}'),
                      //           Text(
                      //             'Departure: ${flight.departureDateTime.toString()}',
                      //             style: TextStyle(fontStyle: FontStyle.italic),
                      //           ),
                      //           Text(
                      //             'Arrival: ${flight.arrivalDateTime.toString()}',
                      //             style: TextStyle(fontStyle: FontStyle.italic),
                      //           ),
                      //         ],
                      //       ),
                      //       trailing: Text('\$${flight.price.toStringAsFixed(2)}'),
                      //       // onTap: () {
                      //       //   // Navigator.push(
                      //       //   //   context,
                      //       //   //   MaterialPageRoute(
                      //       //   //     builder: (context) => SeatBookingPage(
                      //       //   //       flight: flight,
                      //       //   //     ),
                      //       //   //   ),
                      //       //   );
                      //       // },
                      //     );
                      //   },
                      // ),
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
