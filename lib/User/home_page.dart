import 'package:flight_booking_application/User/contactus_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'seatbooking_page.dart';
import 'payment_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  int adults = 1;
  int children = 0;
  List<String> cities = [];
  String? fromCity;
  String? toCity;
  bool isLoadingCities = false;

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    setState(() {
      isLoadingCities = true;
    });

    final url = Uri.parse('http://your_api_endpoint/cities'); // Replace with your API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        cities = List<String>.from(jsonDecode(response.body));
        isLoadingCities = false;
      });
    } else {
      setState(() {
        isLoadingCities = false;
      });
      throw Exception('Failed to load cities');
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
              leading: Icon(Icons.airplane_ticket),
              title: Text('Ticketing'),
              onTap: () {
                // Navigate to ticketing page
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
                // Navigate to contact us page
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
                  color: Color(0xFF800000), // Maroon text color
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // Handle notifications tap
                    },
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/pla.jpg',
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    ToggleButtons(
                      children: [Text('One Way'), Text('Round Trip')],
                      isSelected: [true, false],
                      onPressed: (int index) {
                        // Handle toggle button selection
                      },
                    ),
                    SizedBox(height: 20),
                    isLoadingCities
                        ? CircularProgressIndicator()
                        : DropdownButtonFormField<String>(
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
                    isLoadingCities
                        ? CircularProgressIndicator()
                        : DropdownButtonFormField<String>(
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
                    TextField(
                      controller: returnDateController,
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
                            returnDateController.text =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Return',
                        prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Class',
                        prefixIcon: Icon(Icons.class_, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: <String>['Economy', 'Business', 'Premier', 'VIP']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {
                        // Handle dropdown change
                      },
                    ),
                    SizedBox(height: 20),
                    PassengerDropdown(
                      adults: adults,
                      children: children,
                      onChanged: (passengerData) {
                        setState(() {
                          adults = passengerData['adults']!;
                          children = passengerData['children']!;
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SeatBookingPage()),
                        );
                        // Handle search flights
                      },
                      child: Text(
                        'Search Flights',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
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
  bool dropdownOpened = false;

  @override
  void initState() {
    super.initState();
    adults = widget.adults;
    children = widget.children;
  }

  void toggleDropdown() {
    setState(() {
      dropdownOpened = !dropdownOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Passengers',
              prefixIcon: Icon(Icons.person, color: Color(0xFF800000)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Adults: $adults, Children: $children'),
                Icon(dropdownOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (dropdownOpened)
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF800000)),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adults', style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Color(0xFF800000)),
                          onPressed: () {
                            if (adults > 1) {
                              setState(() {
                                adults--;
                              });
                              widget.onChanged({'adults': adults, 'children': children});
                            }
                          },
                        ),
                        Text('$adults', style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Color(0xFF800000)),
                          onPressed: () {
                            setState(() {
                              adults++;
                            });
                            widget.onChanged({'adults': adults, 'children': children});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Children', style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Color(0xFF800000)),
                          onPressed: () {
                            if (children > 0) {
                              setState(() {
                                children--;
                              });
                              widget.onChanged({'adults': adults, 'children': children});
                            }
                          },
                        ),
                        Text('$children', style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Color(0xFF800000)),
                          onPressed: () {
                            setState(() {
                              children++;
                            });
                            widget.onChanged({'adults': adults, 'children': children});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}