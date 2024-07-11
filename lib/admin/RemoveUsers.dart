import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoveUsers extends StatefulWidget {
  @override
  _RemoveUsersState createState() => _RemoveUsersState();
}

class _RemoveUsersState extends State<RemoveUsers> {
  List<dynamic> users = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    // REST API endpoint to fetch users
    var response = await http.get(Uri.parse('http://192.168.1.63:8000/api/admin/user/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
      });
    } else {
      print('Failed to load users');
    }
  }

  void _filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<dynamic> _getFilteredResults() {
    if (searchQuery.isNotEmpty) {
      return users.where((user) =>
      user['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          user['email'].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    return users;
  }

  Future<void> _removeUser(int id) async {
    // REST API endpoint to delete a user
    var response = await http.delete(Uri.parse('http://192.168.1.63:8000/api/admin/user/delete/$id'));
    if (response.statusCode == 200) {
      setState(() {
        users.removeWhere((user) => user['id'] == id);
        print('Successfully Deleted User:${response.body}');
      });
    } else {
      print('Failed to delete user: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleTextStyle: GoogleFonts.albertSans(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        title: Text('REMOVE USERS'),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
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
              _buildSearchBar(),
              SizedBox(height: 10),
              Expanded(child: _buildUsersList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: _filterSearchResults,
      decoration: InputDecoration(
        labelText: 'Search User by Name or Email',
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildUsersList() {
    List<dynamic> filteredUsers = _getFilteredResults();
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        var user = filteredUsers[index];
        return Card(
          color: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            // title: Text('ID: ${user['id']}'),
            subtitle: Text('Name: ${user['name']},\nEmail: ${user['email']},\n'
                'Address: ${user['address']},\nPhone Number: ${user['phone_number']},\nUsername: ${user['username']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await _removeUser(user['id']);
              },
            ),
          ),
        );
      },
    );
  }
}
