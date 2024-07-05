import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import '../AdminDashboard.dart';
// import '../WelcomeScreen.dart';
import 'AdminDashboard.dart';
import 'WelcomeScreen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;


    //API endpoint
    final url = Uri.parse('http://192.168.1.63:8000/admin/login');


    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      // Debug print to check the request payload
      print('Request payload: ${jsonEncode({'username': username, 'email': email, 'password': password})}');

      // Debug print to check the response status code and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Successful authentication
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        // Handle authentication failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello,\nAdmin!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text('Username', style: TextStyle(color: Colors.black)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                            label: Text('Email Address', style: TextStyle(color: Colors.black)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            final emailRegExp = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            if (!emailRegExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.password, color: Colors.grey),
                            label: Text('Password', style: TextStyle(color: Colors.black)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?', style: TextStyle(color: Colors.red)),
                        ),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text(
                            'ROOT LOGIN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                            );
                          },
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Login as user?", style: TextStyle(color: Colors.grey)),
                                Text(
                                  "Sign in!",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => const AdminRegister()),
                        //     );
                        //   },
                        //   child: const Align(
                        //     alignment: Alignment.bottomCenter,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Text("Admin Register?", style: TextStyle(color: Colors.grey)),
                        //         Text(
                        //           "Root Sign Up!",
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
