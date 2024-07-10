import 'package:flight_booking_application/admin/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'User/home_page.dart';
import 'User/login_page.dart';
import 'admin/AdminDashboard.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == 'user') {
            return HomePage(username: '',);
          } else if (snapshot.data == 'admin') {
            return AdminDashboard();
          } else {
            return WelcomeScreen();
          }
        }
      },
    );
  }

  Future<String?> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');
    return userType; // 'user', 'admin', or null
  }
}
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: const Center(
//         child: Text('Welcome to Home Page'),
//       ),
//     );
//   }
// }
//
// class AdminDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Dashboard'),
//       ),
//       body: const Center(
//         child: Text('Welcome to Admin Dashboard'),
//       ),
//     );
//   }
// }
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Page'),
//       ),
//       body: const Center(
//         child: Text('Please log in'),
//       ),
//     );
//   }
// }
