import 'package:flight_booking_application/WelcomeScreen.dart';
import 'package:flight_booking_application/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flight_booking_application/contactus_page.dart';
import 'package:google_fonts/google_fonts.dart';




void main(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}


//Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: ('AlbertSans_Regular'),
        textTheme: GoogleFonts.albertSansTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.albertSans(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => WelcomeScreen(),
        '/signup': (context) => SignupPage(),
        // '/home': (context) => HomePage(username: 'User'), // Dummy userName for route setup
        '/contact': (context) => ContactUsPage(),
      },
      home: const WelcomeScreen(),

    );
  }
}
