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
  final TextEditingController _aircraftIdController = TextEditingController();

  // Function to add aircraft
  void _addAircraft() async {
    String registrationNumber = _aircraftRegNoController.text;
    int totalSeats = int.tryParse(_aircraftTotalSeatsController.text) ?? 0;
    int economySeats = int.tryParse(_aircraftEconomySeatsController.text) ?? 0;
    int businessSeats = int.tryParse(_aircraftBusinessSeatsController.text) ?? 0;
    int firstClassSeats = int.tryParse(_aircraftFirstClassSeatsController.text) ?? 0;

    var response = await http.post(
      Uri.parse('http://192.168.1.63:8000/api/admin/airplane/create'),
      body: jsonEncode({
        'registration_number': registrationNumber,
        'total_seats': totalSeats,
        'economy_seats': economySeats,
        'business_seats': businessSeats,
        'first_class_seats': firstClassSeats,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      _showSnackbar('Successfully Added Aircraft');
    } else if(response.statusCode == 400) {
      _showSnackbar('Invalid Input or Missing Required Fields');
    }
    else {
      _showSnackbar('Unsuccessful');
    }
  }

  // Function to delete aircraft
  void _deleteAircraft() async {
    String id = _aircraftIdController.text;

    var response = await http.delete(
      Uri.parse('http://192.168.1.63:8000/api/admin/airplane/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Deleted Aircraft');
    } else if(response.statusCode == 404) {
      _showSnackbar('Airplane Not Found');
    } else if(response.statusCode == 500) {
      _showSnackbar('Internal Server Error');
    }
    else {
      _showSnackbar('Unsuccessful');
    }
  }

  // Function to update aircraft
  void _updateAircraft() async {
    String id = _aircraftIdController.text;
    String registrationNumber = _aircraftRegNoController.text;
    int totalSeats = int.tryParse(_aircraftTotalSeatsController.text) ?? 0;
    int economySeats = int.tryParse(_aircraftEconomySeatsController.text) ?? 0;
    int businessSeats = int.tryParse(_aircraftBusinessSeatsController.text) ?? 0;
    int firstClassSeats = int.tryParse(_aircraftFirstClassSeatsController.text) ?? 0;

    var response = await http.patch(
      Uri.parse('http://192.168.1.63:8000/api/admin/airplane/update/$id'),
      body: jsonEncode({
        'registration_number': registrationNumber,
        'total_seats': totalSeats,
        'economy_seats': economySeats,
        'business_seats': businessSeats,
        'first_class_seats': firstClassSeats,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Updated Aircraft');
    } else if(response.statusCode == 400) {
      _showSnackbar('Invalid Input or Missing Required Fields');
    } else if(response.statusCode == 404) {
      _showSnackbar('Airplane Not Found');
    }
    else {
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
                      decoration: InputDecoration(
                        labelText: 'Registration Number(KQXXX)',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftTotalSeatsController,
                      decoration: InputDecoration(
                        labelText: 'Total Seats(000)',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftEconomySeatsController,
                      decoration: InputDecoration(
                        labelText: 'Economy Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftBusinessSeatsController,
                      decoration: InputDecoration(
                        labelText: 'Business Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftFirstClassSeatsController,
                      decoration: InputDecoration(
                        labelText: 'First Class Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _addAircraft,
                      child: Text('ADD'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildExpansionTile(
                  title: 'Delete Aircraft',
                  children: [
                    TextField(
                      controller: _aircraftIdController,
                      decoration: InputDecoration(
                        labelText: 'Airplane ID',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _deleteAircraft,
                      child: Text('DELETE'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildExpansionTile(
                  title: 'Update Aircraft',
                  children: [
                    TextField(
                      controller: _aircraftIdController,
                      decoration: InputDecoration(
                        labelText: 'Airplane ID',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftRegNoController,
                      decoration: InputDecoration(
                        labelText: 'Registration Number(KQXXX)',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftTotalSeatsController,
                      decoration: InputDecoration(
                        labelText: 'Total Seats(000)',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftEconomySeatsController,
                      decoration: InputDecoration(
                        labelText: 'Economy Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftBusinessSeatsController,
                      decoration: InputDecoration(
                        labelText: 'Business Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _aircraftFirstClassSeatsController,
                      decoration: InputDecoration(
                        labelText: 'First Class Seats',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _updateAircraft,
                      child: Text('UPDATE'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        initiallyExpanded: true,
      ),
    );
  }
}
