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
  final TextEditingController _flightIdController = TextEditingController(); // Added controller for flight id

  // Function to add flight
  void _addFlight() async {
    String flightNumber = _flightNumberController.text;
    String departure_date_Time = _departureTimeController.text;
    String arrival_date_Time = _arrivalTimeController.text;
    String departureAirport = _departureAirportController.text;
    String arrivalAirport = _arrivalAirportController.text;

    // REST API endpoint for adding flight
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
      _showSnackbar('Successfully Added Flight');
    } else if(response.statusCode == 400) {
      _showSnackbar('Missing Required Fields or Incorrect Format');
    } else if(response.statusCode == 404) {
      _showSnackbar('Airplane not found');
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

  // Function to delete flight
  void _deleteFlight() async {
    String id = _flightIdController.text; // Use flight id

    // REST API endpoint for deleting flight
    var response = await http.delete(
      Uri.parse('http://192.168.1.63:8000/api/admin/wing/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Deleted Flight');
    } else if(response.statusCode == 404) {
      _showSnackbar('Flight Not Found');
    }
    else {
      _showSnackbar('Unsuccessful');
    }
  }

  // Function to update flight
  void _updateFlight() async {
    String id = _flightIdController.text; // Use flight id
    String flightNumber = _flightNumberController.text;
    String departure_date_Time = _departureTimeController.text;
    String arrival_date_Time = _arrivalTimeController.text;
    String departureAirport = _departureAirportController.text;
    String arrivalAirport = _arrivalAirportController.text;

    // REST API endpoint for updating flight
    var response = await http.patch(
      Uri.parse('http://192.168.1.63:8000/api/admin/wing/update/$id'),
      body: jsonEncode({
        'flight_number': flightNumber,
        'departure_date_time': departure_date_Time,
        'arrival_date_time': arrival_date_Time,
        'departure_airport': departureAirport,
        'arrival_airport': arrivalAirport,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);

    if (response.statusCode == 200) {
      _showSnackbar('Successfully Updated Flight');
    } else if(response.statusCode == 400) {
      _showSnackbar('Missing Required Fields');
    } else if(response.statusCode == 404) {
      _showSnackbar('Flight Not Found');
    }
    else {
      _showSnackbar('Unsuccessful');
    }
  }
//datetime picker
  Future<void> _selectDateTime(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.highContrastLight(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.pink, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.highContrastLight(
                primary: Colors.pink, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.text = fullDateTime.toString();
      }
    }
  }

  // Header
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
      // Body
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
                    // Input fields with controllers
                    TextField(
                      controller: _flightNumberController,
                      decoration: InputDecoration(
                        labelText: 'Flight Number',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _departureTimeController,
                      decoration: InputDecoration(
                        labelText: 'Departure Date and Time',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDateTime(_departureTimeController);
                      },
                    ),
                    TextField(
                      controller: _arrivalTimeController,
                      decoration: InputDecoration(
                        labelText: 'Arrival Date and Time',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDateTime(_arrivalTimeController);
                      },
                    ),
                    TextField(
                      controller: _departureAirportController,
                      decoration: InputDecoration(
                        labelText: 'Departure Airport',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _arrivalAirportController,
                      decoration: InputDecoration(
                        labelText: 'Arrival Airport',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Button to add
                    ElevatedButton(
                      onPressed: _addFlight,
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
                  title: 'Delete Flight',
                  children: [
                    TextField(
                      controller: _flightIdController, // Use flight id
                      decoration: InputDecoration(labelText: 'Flight ID'),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _deleteFlight,
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
                  title: 'Update Flight',
                  children: [
                    TextField(
                      controller: _flightIdController, // Use flight id
                      decoration: InputDecoration(
                        labelText: 'Flight ID',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _flightNumberController,
                      decoration: InputDecoration(
                        labelText: 'Flight Number',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _departureTimeController,
                      decoration: InputDecoration(
                        labelText: 'Departure Date and Time',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDateTime(_departureTimeController);
                      },
                    ),
                    TextField(
                      controller: _arrivalTimeController,
                      decoration: InputDecoration(
                        labelText: 'Arrival Date and Time',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDateTime(_arrivalTimeController);
                      },
                    ),
                    TextField(
                      controller: _departureAirportController,
                      decoration: InputDecoration(
                        labelText: 'Departure Airport',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    TextField(
                      controller: _arrivalAirportController,
                      decoration: InputDecoration(
                        labelText: 'Arrival Airport',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: false,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _updateFlight,
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
  // Editing of the expansion tiles when closed and when open
  Widget _buildExpansionTile
      ({required String title, required List<Widget> children}) {
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


//
//   Widget _buildExpansionTile({required String title, required List<Widget> children}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ExpansionTile(
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         children: children,
//       ),
//     );
//   }
// }
