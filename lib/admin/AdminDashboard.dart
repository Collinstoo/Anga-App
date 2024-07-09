import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AddAirport.dart';
import 'AddAircraft.dart';
import 'AddFlight.dart';
import 'Overview.dart';
import 'RemoveUsers.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/admin-login');
        return false;
      },
      child: Scaffold(
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
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/admin-login');
              },
            ),
          ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

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
