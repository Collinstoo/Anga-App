import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAirport extends StatefulWidget {
  @override
  _AddAirportState createState() => _AddAirportState();
}

class _AddAirportState extends State<AddAirport> {
  final TextEditingController _airportNameController = TextEditingController();
  final TextEditingController _airportCountryController = TextEditingController();
  final TextEditingController _airportCityController = TextEditingController();
  final TextEditingController _airportIdController = TextEditingController();

  // Function to add airport
  void _addAirport() async {
    String name = _airportNameController.text;
    String country = _airportCountryController.text;
    String city = _airportCityController.text;

    // REST API endpoint to add airport
    var response = await http.post(
      Uri.parse('http://192.168.1.63:8000/api/airport/create'),
      body: jsonEncode({
        'airport_name': name,
        'country': country,
        'city': city,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Assuming success response code is 200
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

  // Function to delete airport
  void _deleteAirport() async {
    String id = _airportIdController.text;

    // REST API endpoint to delete airport
    var response = await http.delete(
      Uri.parse('http://192.168.1.63:8000/api/airport/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Deleted');
    } else {
      _showSnackbar('Unsuccessful');
    }
  }

  // Function to update airport
  void _updateAirport() async {
    String id = _airportIdController.text;
    String name = _airportNameController.text;
    String country = _airportCountryController.text;
    String city = _airportCityController.text;

    // REST API endpoint to update airport
    var response = await http.put(
      Uri.parse('http://192.168.1.63:8000/api/airport/update/$id'),
      body: jsonEncode({
        'name': name,
        'country': country,
        'city': city,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Updated');
    } else {
      _showSnackbar('Unsuccessful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('AIRPORT'),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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
                  title: 'Add Airport',
                  children: [
                    TextField(
                      controller: _airportNameController,
                      decoration: InputDecoration(
                        labelText: 'Airport Name',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _airportCountryController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _airportCityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                      onPressed: _addAirport,
                      child: Text('ADD'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _buildExpansionTile(
                  title: 'Delete Airport',
                  children: [
                    TextField(
                      controller: _airportIdController,
                      decoration: InputDecoration(
                        labelText: 'Airport ID',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                      onPressed: _deleteAirport,
                      child: Text('DELETE'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _buildExpansionTile(
                  title: 'Update Airport',
                  children: [
                    TextField(
                      controller: _airportIdController,
                      decoration: InputDecoration(
                        labelText: 'Airport ID',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _airportNameController,
                      decoration: InputDecoration(
                        labelText: 'Airport Name',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _airportCountryController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _airportCityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ElevatedButton(
                      onPressed: _updateAirport,
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
