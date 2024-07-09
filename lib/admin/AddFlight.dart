import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddFlight extends StatefulWidget {
  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {
  final TextEditingController _flightNumberController = TextEditingController();

  final TextEditingController _departureTimeController = TextEditingController();

  final TextEditingController _arrivalTimeController = TextEditingController();

  final TextEditingController _departureAirportController = TextEditingController();

  final TextEditingController _arrivalAirportController = TextEditingController();


  //function to add flight
  void _addFlight() async {
    String flightNumber = _flightNumberController.text;
    String departure_date_Time = _departureTimeController.text;
    String arrival_date_Time = _arrivalTimeController.text;
    String departureAirport = _departureAirportController.text;
    String arrivalAirport = _arrivalAirportController.text;


    //  REST API endpoint for add flight
    var response = await http.post(
      Uri.parse('http://192.168.1.63:8000/api/admin/wing/create'),
      body: jsonEncode({
        'flight_number': flightNumber,
        'departure_date_time': departure_date_Time,
        'arrival_date_time': arrival_date_Time,
        'departure_airport': departureAirport,
        'arrival_airport': arrivalAirport,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      _showSnackbar('Successfully Added');
    } else {
      _showSnackbar('Unsuccessful');
    }
  }
  // Function to show snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  //function to delete flight
  void _deleteFlight() async {
    String flightNumber = _flightNumberController.text;

    //  REST API endpoint for deleting flight
    var response = await http.delete(
      Uri.parse('http://yourapi.com/api/admin/wing/delete/$flightNumber'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }

  //function to update flight
  void _updateFlight() async {
    String flightNumber = _flightNumberController.text;
    String departure_date_Time = _departureTimeController.text;
    String arrival_date_Time = _arrivalTimeController.text;
    String departureAirport = _departureAirportController.text;
    String arrivalAirport = _arrivalAirportController.text;

    //  REST API endpoint for updating flight
    var response = await http.patch(
      Uri.parse('http://yourapi.com/api/admin/wing/update/$flightNumber'),
      body: jsonEncode({
        'departure_date_time': departure_date_Time,
        'arrival_date_time': arrival_date_Time,
        'departure_airport': departureAirport,
        'arrival_airport': arrivalAirport,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }


  //header
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text('FLIGHT'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),


      //body
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.6, 1.0],
            colors: [Colors.black, Colors.pink],
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildExpansionTile(
                  title: 'Add Flight',
                  children: [
                    //input fields with controllers
                    TextField(
                      controller: _flightNumberController,
                      decoration: InputDecoration(labelText: 'Flight Number', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _departureTimeController,
                      decoration: InputDecoration(labelText: 'Departure  Date and Time', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _arrivalTimeController,
                      decoration: InputDecoration(labelText: 'Arrival  Date and Time', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _departureAirportController,
                      decoration: InputDecoration(labelText: 'Departure Airport', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _arrivalAirportController,
                      decoration: InputDecoration(labelText: 'Arrival Airport', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15),
                    //button to add
                    ElevatedButton(
                      onPressed: _addFlight,
                      child: Text('ADD'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildExpansionTile(
                  title: 'Delete Flight',
                  children: [
                    TextField(
                      controller: _flightNumberController,
                      decoration: InputDecoration(labelText: 'Flight Number'),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _deleteFlight,
                      child: Text('DELETE'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildExpansionTile(
                  title: 'Update Flight',
                  children: [
                    TextField(
                      controller: _flightNumberController,
                      decoration: InputDecoration(labelText: 'Flight Number', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _departureTimeController,
                      decoration: InputDecoration(labelText: 'Departure Time', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _arrivalTimeController,
                      decoration: InputDecoration(labelText: 'Arrival Time', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _departureAirportController,
                      decoration: InputDecoration(labelText: 'Departure Airport', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _arrivalAirportController,
                      decoration: InputDecoration(labelText: 'Arrival Airport', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15),

                    //button to update
                    ElevatedButton(
                      onPressed: _updateFlight,
                      child: Text('UPDATE'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //editing of the expansion tiles when closed and when open
  Widget _buildExpansionTile({required String title, required List<Widget> children}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: true, // Expand the tile initially
      ),
    );
  }
}
