import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome To Profile Page",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.w600,
            ),
          ),
          ],
        ),
      )
      
    );
  }
}