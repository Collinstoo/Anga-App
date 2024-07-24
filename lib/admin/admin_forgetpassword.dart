import 'package:flutter/material.dart';

class AdminForgetpassword extends StatefulWidget {
  const AdminForgetpassword({super.key});

  @override
  State<AdminForgetpassword> createState() => _AdminForgetpasswordState();
}

class _AdminForgetpasswordState extends State<AdminForgetpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              SizedBox(height: 40,),
              Align(
                alignment: Alignment(-1.1,0),
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment(-1,0),
                child: Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Text(
                'Enter your email to forget password',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Align(
                alignment: Alignment(-1,0),
                child: Text(
                  'Your Email',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email_outlined, color: Colors.grey,),
                  label: Text('Email address', style: TextStyle(color: Colors.grey),),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {  },
                // onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),

                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
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
