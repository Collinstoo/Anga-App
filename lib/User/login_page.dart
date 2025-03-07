import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
import 'session_manager.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Loading indicator

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final username = await SessionManager.getUser();
    if (username != null) {
      // Navigate to home page if user is already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: username),
        ),
      );
    }
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('http://192.168.1.63:8000/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        String username = user['name'] ?? '';
        await SessionManager.saveUser(username);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(username: username)),
        );
      } else {
        showError('Failed to login. Please check your credentials.');
      }
    } catch (e) {
      showError('An error occurred. Please try again.');
      print('Login error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark maroon background color
      appBar: AppBar(
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('LOGIN'),
        backgroundColor: Colors.pink, // Dark maroon app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.pink,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF800000),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF800000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                        setState(() {
                          isLoading = true;
                        });
                        final email = emailController.text;
                        final password = passwordController.text;
                        await loginUser(email, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF800000),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: Color(0xFF800000)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Color(0xFF800000)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
