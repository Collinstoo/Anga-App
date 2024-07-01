import 'package:flight_booking_application/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_application/signup_page.dart';
import 'package:flight_booking_application/login_page.dart';
import 'AdminLogin.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(


                colors: [
                  Colors.black,
                  Colors.pink,
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(100.0, 100.0, 100.0, 40.0),
                child: Image(image: AssetImage('assets/logo.png')),
              ),
              const Text('WELCOME',style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
              ),),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('LOGIN',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('REGISTER',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AdminLogin()));
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(child: Text('ADMIN',style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                  ),),),
                ),
              ),
              const SizedBox(height: 100,),
            ]
        ),
      ),

    );
  }
}