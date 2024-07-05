import 'package:flutter/material.dart';

class TicketingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Your Ticket',
          style: TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[300],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[100]!, Colors.blue[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[200]!,
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.airplane_ticket,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Flight Ticket',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                      ),
                      SizedBox(height: 20),
                      Divider(thickness: 2),
                      SizedBox(height: 20),
                      Text(
                        'Your ticket details go here.',
                        style: TextStyle(fontSize: 18, color: Colors.blue[800]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Divider(thickness: 2),
                      SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {

                          Navigator.pop(context); // Example navigation back
                        },
                        child: Text(
                          'Back to Home',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
