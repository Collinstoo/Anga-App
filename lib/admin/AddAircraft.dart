import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAircraft extends StatefulWidget {
  @override
  State<AddAircraft> createState() => _AddAircraftState();
}

class _AddAircraftState extends State<AddAircraft> {
  final TextEditingController _aircraftRegNoController = TextEditingController();

  final TextEditingController _aircraftTotalSeatsController = TextEditingController();

  final TextEditingController _aircraftEconomySeatsController = TextEditingController();

  final TextEditingController _aircraftBusinessSeatsController = TextEditingController();

  final TextEditingController _aircraftFirstClassSeatsController = TextEditingController();


  //function to add aircraft
  void _addAircraft() async {
    String registration_number = _aircraftRegNoController.text;
    int total_seats = int.tryParse(_aircraftTotalSeatsController.text) ?? 0;
    int economy_seats = int.tryParse(_aircraftEconomySeatsController.text) ?? 0;
    int business_seats = int.tryParse(_aircraftBusinessSeatsController.text) ?? 0;
    int first_class_seats = int.tryParse(_aircraftFirstClassSeatsController.text) ?? 0;

    // REST API endpoint for adding aircraft
    var response = await http.post(
      Uri.parse('http://192.168.1.63:8000/api/airplane/airplanes/create'),
      body: jsonEncode({
        'registration_number': registration_number,
        'total_seats': total_seats,
        'economy_seats': economy_seats,
        'business_seats': business_seats,
        'first_class_seats': first_class_seats,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }

  //function to delete aircraft
  void _deleteAircraft() async {
    String registration_number = _aircraftRegNoController.text;

    //  REST API endpoint for deleting aircraft
    var response = await http.delete(
      Uri.parse('http://192.168.1.63:8000/api/airplane/airplanes/$registration_number'), // Update this URL
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }


  //function to update aircraft
  void _updateAircraft() async {
    String registration_number = _aircraftRegNoController.text;
    int total_seats = int.tryParse(_aircraftTotalSeatsController.text) ?? 0;
    int economy_seats = int.tryParse(_aircraftEconomySeatsController.text) ?? 0;
    int business_seats = int.tryParse(_aircraftBusinessSeatsController.text) ?? 0;
    int first_class_seats = int.tryParse(_aircraftFirstClassSeatsController.text) ?? 0;


    // REST API endpoint to update aircraft
    var response = await http.put(
      Uri.parse('http://192.168.1.63:8000/api/airplane/airplanes/$registration_number'),
      body: jsonEncode({
        'total_seats': total_seats,
        'economy_seats': economy_seats,
        'business_seats': business_seats,
        'first_class_seats': first_class_seats,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        title: Text('AIRCRAFT'),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),


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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildExpansionTile(
                  title: 'Add Aircraft',
                  children: [
                    TextField(
                      controller: _aircraftRegNoController,
                      decoration: InputDecoration(labelText: 'Registration Number', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftTotalSeatsController,
                      decoration: InputDecoration(labelText: 'Total Seats', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftEconomySeatsController,
                      decoration: InputDecoration(labelText: 'Economy Seats', labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftBusinessSeatsController,
                      decoration: InputDecoration(labelText: 'Business Seats',labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftFirstClassSeatsController,
                      decoration: InputDecoration(labelText: 'First Class Seats',labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _addAircraft,
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
                  title: 'Delete Aircraft',
                  children: [
                    TextField(
                      controller: _aircraftRegNoController,
                      decoration: InputDecoration(labelText: 'Registration Number',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _deleteAircraft,
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
                  title: 'Update Aircraft',
                  children: [
                    TextField(
                      controller: _aircraftRegNoController,
                      decoration: InputDecoration(labelText: 'Registration Number',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftTotalSeatsController,
                      decoration: InputDecoration(labelText: 'Total Seats',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftEconomySeatsController,
                      decoration: InputDecoration(labelText: 'Economy Seats',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftBusinessSeatsController,
                      decoration: InputDecoration(labelText: 'Business Seats',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _aircraftFirstClassSeatsController,
                      decoration: InputDecoration(labelText: 'First Class Seats',labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _updateAircraft,
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

  Widget _buildExpansionTile({required String title, required List<Widget> children}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0), // Adjust the radius as needed
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
              borderRadius: BorderRadius.circular(10.0), // Same radius as ClipRRect
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
