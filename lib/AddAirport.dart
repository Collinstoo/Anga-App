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


  //function to add airport
  void _addAirport() async {
    String id = _airportIdController.text;
    String name = _airportNameController.text;
    String country = _airportCountryController.text;
    String city = _airportCityController.text;

    //  REST API endpoint to add airport
    var response = await http.post(
      Uri.parse('http://192.168.1.63:8000/api/airport/airports/create'),
      body: jsonEncode({
        'airport_id': id,
        'name': name,
        'country': country,
        'city': city
      }),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }


  //function to delete airport
  void _deleteAirport() async {
    String id = _airportIdController.text;

    //  REST API endpoint to delete flight
    var response = await http.delete(
      Uri.parse('https://ca919789b23e6c49801b.free.beeceptor.com/api/airport/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
  }

  //function to update airport
  void _updateAirport() async {
    String id = _airportIdController.text;
    String name = _airportNameController.text;
    String country = _airportCountryController.text;
    String city = _airportCityController.text;

    //  REST API endpoint to update airport
    var response = await http.put(
      Uri.parse('http://yourapi.com/api/airport/update/$id'), // Update this URL
      body: jsonEncode({
        'name': name,
        'country': country,
        'city': city
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
                      controller: _airportIdController,
                      decoration: InputDecoration(labelText: 'Airport ID',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportNameController,
                      decoration: InputDecoration(labelText: 'Airport Name',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportCountryController,
                      decoration: InputDecoration(labelText: 'Country',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportCityController,
                      decoration: InputDecoration(labelText: 'City',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                      onPressed: _addAirport,
                      child: Text('ADD'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
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
                      decoration: InputDecoration(labelText: 'Airport ID',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                      onPressed: _deleteAirport,
                      child: Text('DELETE',),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0), // Add space between tiles
                _buildExpansionTile(
                  title: 'Update Airport',
                  children: [
                    TextField(
                      controller: _airportIdController,
                      decoration: InputDecoration(labelText: 'Airport ID',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportNameController,
                      decoration: InputDecoration(labelText: 'Airport Name',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportCountryController,
                      decoration: InputDecoration(labelText: 'Country',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    TextField(
                      controller: _airportCityController,
                      decoration: InputDecoration(labelText: 'City',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: false,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                      onPressed: _updateAirport,
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

  Widget _buildExpansionTile(
      {required String title, required List<Widget> children}) {
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
              borderRadius: BorderRadius.circular(
                  10.0), // Same radius as ClipRRect
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
