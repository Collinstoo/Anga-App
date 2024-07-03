import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class OverView extends StatefulWidget {
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  List<dynamic> airports = [];
  List<dynamic> aircrafts = [];
  List<dynamic> flights = [];
  List<dynamic> bookings = [];
  List<dynamic> passengers = [];
  List<dynamic> tickets = [];
  String searchQuery = '';
  String filter = 'Airports';

  @override
  void initState() {
    super.initState();
    _fetchAirports();
    _fetchAirplanes();
    _fetchPassengers();
    _fetchFLights();
    _fetchBookings();
    _fetchTickets();

  }

  Future<void> _fetchAirports() async {
    // REST API endpoint to fetch airports
    var airportsResponse = await http.get(
        Uri.parse('http://192.168.1.63:8000/api/airport/airports'));
    if (airportsResponse.statusCode == 200) {
      setState(() {
        airports = jsonDecode(airportsResponse.body);
      });
    } else {
      print('Failed to fetch airports');
    }
  }

  Future<void> _fetchAirplanes() async {
    // REST API endpoint to fetch aircrafts
    var aircraftsResponse = await http.get(
        Uri.parse('http://192.168.1.63:8000/api/airplane/airplanes'));
    if (aircraftsResponse.statusCode == 200) {
      setState(() {
        aircrafts = jsonDecode(aircraftsResponse.body);
      });
    } else {
      print('Failed to fetch aircrafts');
    }
  }


  Future<void> _fetchFLights() async {
    // REST API endpoint to fetch flights
    var flightsResponse = await http.get(
        Uri.parse('http://192.168.1.63:8000/api/flights/flights'));
    if (flightsResponse.statusCode == 200) {
      setState(() {
        flights = jsonDecode(flightsResponse.body);
      });
    } else {
      print('Failed to fetch flights');
    }
  }


    Future<void> _fetchBookings() async {
      // REST API endpoint to fetch bookings
      var bookingsResponse = await http.get(
          Uri.parse('http://192.168.1.23:8087/api/bookings'));
      if (bookingsResponse.statusCode == 200) {
        setState(() {
          bookings = jsonDecode(bookingsResponse.body);
        });
      } else {
        print('Failed to fetch bookings');
      }
    }


  Future<void> _fetchPassengers() async {
    // REST API endpoint to fetch passengers
    var passengersResponse = await http.get(
        Uri.parse('http://192.168.1.23:8087/api/passengers'));
    if (passengersResponse.statusCode == 200) {
      setState(() {
        passengers = jsonDecode(passengersResponse.body);
      });
    } else {
      print('Failed to fetch passengers');
    }
  }


  Future<void> _fetchTickets() async {
    // REST API endpoint to fetch tickets
    var ticketsResponse = await http.get(Uri.parse('http://192.168.1.23:8087/api/tickets'));
    if (ticketsResponse.statusCode == 200) {
      setState(() {
        tickets = jsonDecode(ticketsResponse.body);
      });
    } else {
      print('Failed to fetch tickets');
    }
  }


  void _filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<dynamic> _getFilteredResults() {
    List<dynamic> results = [];
    switch (filter) {
      case 'Airports':
        results = airports;
        break;
      case 'Aircrafts':
        results = aircrafts;
        break;
      case 'Flights':
        results = flights;
        break;
      case 'Bookings':
        results = bookings;
        break;
      case 'Passengers':
        results = passengers;
        break;
      case 'Tickets':
        results = tickets;
        break;
    }
    if (searchQuery.isNotEmpty) {
      results = results.where((item) => item['id'].toString().contains(searchQuery)).toList();
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('OVERVIEW'),
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
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
          child: Column(
            children: [
              _buildSearchBar(),
              SizedBox(height: 10),
              _buildFilterOptions(),
              SizedBox(height: 10),
              Expanded(child: _buildResultsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: _filterSearchResults,
      decoration: InputDecoration(
        labelText: 'Search by ID',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('Airports'),
            _buildFilterButton('Aircrafts'),
            _buildFilterButton('Bookings'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('Tickets'),
            _buildFilterButton('Passengers'),
            _buildFilterButton('Flights'),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterButton(String filterOption) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: filter == filterOption ? Colors.white : Colors.black,
        backgroundColor: filter == filterOption ? Colors.pink : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: () {
        setState(() {
          filter = filterOption;
        });
      },
      child: Text(filterOption),
    );
  }

  Widget _buildResultsList() {
    List<dynamic> filteredResults = _getFilteredResults();
    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        var item = filteredResults[index];
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          elevation: 5.0,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            title: Text('ID: ${item['id']}'),
            subtitle: Text(_getItemSubtitle(item)),
          ),
        );
      },
    );
  }

  String _getItemSubtitle(dynamic item) {
    switch (filter) {
      case 'Airports':
        return 'Name: ${item['name']},\nID: ${item['airport_id']},\nCountry: ${item['country']},\nCity: ${item['city']}';
      case 'Aircrafts':
        return 'Registration: ${item['registration_number']},\nTotal Seats: ${item['total_seats']},'
            '\nEconomy Seats: ${item['economy_seats']},\nBusiness Seats: ${item['business_seats']}';
      case 'Tickets':
        return 'Booking ID: ${item['bookingId']},\nPassenger ID: ${item['passengerId']},\n'
            'Class Type: ${item['classType']},\nFlight ID: ${item['flightId']},\nIssue Date: ${item['issueDate']},\n'
            'Seat Number: ${item['seatNumber']},\nStatus: ${item['status']},\nTicket Number: ${item['ticketNumber']},'
            '\nCreated At: ${item['createdAt']},\nUpdated At: ${item['updatedAt']}';
      case 'Passengers':
        return 'Booking ID: ${item['bookingId']},\nFirst Name: ${item['firstName']},\n'
            'Last Name: ${item['lastName']},\nDate of Birth: ${item['dateOfBirth']},\n'
            'Class Type: ${item['classType']},\nNationality: ${item['nationality']},\n'
            'Passport Number: ${item['passportNumber']},\nSeat Number: ${item['seatNumber']},'
            '\nCreated At: ${item['createdAt']},\nUpdated At: ${item['updatedAt']}';
      case 'Bookings':
        return 'Class Type: ${item['classType']},\nFlight Number: ${item['flightId']},\n'
            'Status: ${item['status']},\nUser ID: ${item['userId']},'
            '\nCreated At: ${item['createdAt']},\nUpdated At: ${item['updatedAt']}';
      case 'Flights':
        return 'Flight Number: ${item['Flight_Number']},\nDeparture Airport: ${item['Departure_Airport']},\n'
            'Arrival Airport: ${item['Arrival_Airport']},\nPrice: ${item['Price']},\nCapacity: ${item['Capacity']},\n'
            'Arrival Date and Time: ${item['Arrival_Date_Time']},\nDeparture Date and Time: ${item['Departure_Date_Time']}';
      default:
        return '';
    }
  }
}





























// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class OverView extends StatefulWidget {
//   @override
//   _OverViewState createState() => _OverViewState();
// }
//
// class _OverViewState extends State<OverView> {
//   List<dynamic> airports = [];
//   List<dynamic> aircrafts = [];
//   List<dynamic> flights = [];
//   List<dynamic> bookings = [];
//   List<dynamic> passengers = [];
//   List<dynamic> tickets = [];
//   String searchQuery = '';
//   String filter = 'Bookings';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }
//
//   Future<void> _fetchData() async {
//     //  REST API endpoint to fetch airports
//     var airportsResponse = await http.get(Uri.parse('http://192.168.1.63:8000/api/airport'));
//     if (airportsResponse.statusCode == 200) {
//       setState(() {
//         airports = jsonDecode(airportsResponse.body);
//       });
//     }
//
//     //  REST API endpoint to fetch aircrafts
//     var aircraftsResponse = await http.get(Uri.parse('http://192.168.1.63:8000/api/aircrafts'));
//     if (aircraftsResponse.statusCode == 200) {
//       setState(() {
//         aircrafts = jsonDecode(aircraftsResponse.body);
//       });
//     }
//
//     //  REST API endpoint to fetch flights
//     var flightsResponse = await http.get(Uri.parse('http://192.168.1.63:8000/api/flights'));
//     if (flightsResponse.statusCode == 200) {
//       setState(() {
//         flights = jsonDecode(flightsResponse.body);
//       });
//     }
//     //  REST API endpoint to fetch bookings
//     var bookingsResponse = await http.get(Uri.parse('http://192.168.1.23:8087/api/bookings'));
//     if (bookingsResponse.statusCode == 200) {
//       setState(() {
//         bookings = jsonDecode(bookingsResponse.body);
//       });
//     }
//     //  REST API endpoint to fetch passengers
//     var passengersResponse = await http.get(Uri.parse('http://192.168.1.23:8087/api/passengers'));
//     if (passengersResponse.statusCode == 200) {
//       setState(() {
//         passengers = jsonDecode(passengersResponse.body);
//       });
//     }
//     //  REST API endpoint to fetch tickets
//     var ticketsResponse = await http.get(Uri.parse('http://192.168.1.23:8087/api/tickets'));
//     if (ticketsResponse.statusCode == 200) {
//       setState(() {
//         tickets = jsonDecode(ticketsResponse.body);
//       });
//     }
//   }
//
//   void _filterSearchResults(String query) {
//     setState(() {
//       searchQuery = query;
//     });
//   }
//
//   List<dynamic> _getFilteredResults() {
//     List<dynamic> results = [];
//     switch (filter) {
//       case 'Airports':
//         results = airports;
//         break;
//       case 'Aircrafts':
//         results = aircrafts;
//         break;
//       case 'Flights':
//         results = flights;
//         break;
//         case 'Bookings':
//         results = bookings;
//         break;
//         case 'Passengers':
//         results = passengers;
//         break;
//         case 'Tickets':
//         results = tickets;
//         break;
//     }
//     if (searchQuery.isNotEmpty) {
//       results = results.where((item) => item['id'].toString().contains(searchQuery)).toList();
//     }
//     return results;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         title: Text('OVERVIEW'),
//         titleTextStyle: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 17.0,
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             stops: [0.6, 1.0],
//             colors: [Colors.black, Colors.pink],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               _buildSearchBar(),
//               SizedBox(height: 10),
//               _buildFilterOptions(),
//               SizedBox(height: 10),
//               Expanded(child: _buildResultsList()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return TextField(
//       onChanged: _filterSearchResults,
//       decoration: InputDecoration(
//         labelText: 'Search by ID',
//         fillColor: Colors.white,
//         filled: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         prefixIcon: Icon(Icons.search),
//       ),
//     );
//   }
//
//   Widget _buildFilterOptions() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildFilterButton('Bookings'),
//             _buildFilterButton('Aircrafts'),
//             _buildFilterButton('Tickets'),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildFilterButton('Passengers'),
//             _buildFilterButton('Airports'),
//             _buildFilterButton('Flights'),
//           ],
//         ),
//
//       ],
//     );
//   }
//
//   Widget _buildFilterButton(String filterOption) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: filter == filterOption ? Colors.white : Colors.black, backgroundColor: filter == filterOption ? Colors.pink : Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//       onPressed: () {
//         setState(() {
//           filter = filterOption;
//         });
//       },
//       child: Text(filterOption),
//     );
//   }
//
//   Widget _buildResultsList() {
//     List<dynamic> filteredResults = _getFilteredResults();
//     return ListView.builder(
//       itemCount: filteredResults.length,
//       itemBuilder: (context, index) {
//         var item = filteredResults[index];
//         return Card(
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 5.0,
//           margin: EdgeInsets.symmetric(vertical: 10.0),
//           child: ListTile(
//             title: Text('ID: ${item['id']}'),
//             subtitle: Text(_getItemSubtitle(item)),
//           ),
//         );
//       },
//     );
//   }
//
//   String _getItemSubtitle(dynamic item) {
//     switch (filter) {
//       case 'airports':
//         return 'Name: ${item['name']}'
//             'ID: ${item['airport_id']}, Country: ${item['country']}, City: ${item['city']}';
//
//
//         case 'aircrafts':
//         return 'Registration: ${item['registration_number']}, Total Seats: ${item['total_seats']}';
//
//
//         case 'tickets':
//         return 'ID: ${item['id']}, Booking ID: ${item['booking_id']}, Passenger ID: ${item['passenger_id']},'
//             'Class Type: ${item['class_type']}, Flight ID: ${item['flight_id']}, Issue Date: ${item['issue_date']},'
//             'Seat Number: ${item['seat_number']}, Status: ${item['status']}, Ticket Number: ${item['ticket_number']}';
//
//
//         case 'passengers':
//         return 'ID: ${item['id']},Booking ID: ${item['booking_id']}, First Name: ${item['first_name']}, '
//             'Last Name: ${item['last_name']}, Date of Birth: ${item['date_of_birth']}, '
//             'Class Type: ${item['class_type']}, Nationality: ${item['nationality']},'
//             ' Passport Number: ${item['passport_number']}, Seat Number: ${item['seat_number']}';
//
//
//         case 'bookings':
//         return 'ID: ${item['id']}, Class Type: ${item['class_type']}, Flight Number: ${item['flight_id']},'
//             'Status: ${item['status']}, User ID: ${item['user_id']}';
//
//
//       case 'flights':
//         return 'Flight Number: ${item['flight_number']}, Departure: ${item['departure_airport']}, Arrival: ${item['arrival_airport']}';
//
//
//       default:
//         return '';
//     }
//   }
// }
