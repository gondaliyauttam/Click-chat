import 'package:clickchat/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

class Splace extends StatefulWidget {
  @override
  _SplaceState createState() => _SplaceState();
}

class _SplaceState extends State<Splace> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.teal[100],
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Open WhatsApp and send message to single number without saving user\'s number.',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/images/chat.png",
            height: 100,
            width: 100,
          ),
        ],
      ),
    ));
  }
}
