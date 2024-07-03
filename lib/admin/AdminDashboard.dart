// import 'package:flight_booking_application/Admin/Overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AddAirport.dart';
import 'AddAircraft.dart';
// import '../AddFlight.dart';
import 'AddFlight.dart';
import 'Overview.dart';
import 'RemoveUsers.dart';
// Import RemoveUsers.dart if you have this file

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,

    ));
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('ADMIN'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 17,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
            stops: [0.6,1.0],
            colors: [Colors.black, Colors.pink],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSquareButton(context, 'Airport', Icons.location_on, AddAirport()),
                  _buildSquareButton(context, 'Aircraft', Icons.airplanemode_active, AddAircraft()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSquareButton(context, 'Flight', Icons.flight_takeoff, AddFlight()),
                  _buildSquareButton(context, 'Users', Icons.person, RemoveUsers()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildSquareButton(context, 'Overview', Icons.edit, OverView()),

                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: _buildSquareButton(context, 'Flight', Icons.flight_takeoff, AddFlight(), isFullWidth: true),
              // ),
              // SizedBox(height: 50.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => RemoveUsers()),
              //         );
              //       },
              //       icon: Icon(Icons.remove_circle, color: Colors.red),
              //       label: Text('REMOVE USERS', style: TextStyle(color: Colors.white)),
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.black,
              //           padding: EdgeInsets.symmetric(vertical: 16.0)
              //       ),
              //     ),
              //   ],
              // ),

              // Uncomment this line if you have a RemoveUsers page
              // _buildSquareButton(context, 'Remove Users', Icons.person_remove, RemoveUsers(), isFullWidth: true),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSectionTitle(String title) {
  //   return Text(
  //     title,
  //     style: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //       fontSize: 15,
  //     ),
  //   );
  // }

  Widget _buildSquareButton(BuildContext context, String title, IconData icon, Widget page, {bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : MediaQuery.of(context).size.width * 0.4,
      height: 100.0,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0),
            SizedBox(height: 10.0),
            Text(title),
          ],
        ),
      ),
    );
  }
}
