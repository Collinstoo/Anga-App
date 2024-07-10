import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddAirport.dart';
import 'AddAircraft.dart';
import 'AddFlight.dart';
import 'Overview.dart';
import 'RemoveUsers.dart';
import 'AdminLogin.dart';
// import 'package:flutter_any_logo/flutter_logo.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:ionicons/ionicons.dart';

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
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(SolarIconsOutline.logout_3),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLogin()),
                );
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
                    _buildSquareButton(context, 'Airport', Ionicons.location_outline, AddAirport()),
                    _buildSquareButton(context, 'Aircraft', Ionicons.airplane_outline, AddAircraft()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSquareButton(context, 'Flight', SolarIconsOutline.traffic, AddFlight()),
                    _buildSquareButton(context, 'Users', Ionicons.person_outline, RemoveUsers()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSquareButton(context, 'Overview', SolarIconsOutline.penNewRound, OverView()),
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
