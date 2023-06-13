import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class GotDetailsBack extends StatefulWidget {
  final Map<String, dynamic> serverDataURL;

  const GotDetailsBack({Key? key, required this.serverDataURL})
      : super(key: key);

  @override
  State<GotDetailsBack> createState() => _GotDetailsBackState();
}

class _GotDetailsBackState extends State<GotDetailsBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User\'s Code'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "New QR Code:",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("The user has been registered succesfuly.\n"+widget.serverDataURL['firstName']+" "+widget.serverDataURL['lastName']+"\n"+"Email: "+widget.serverDataURL['email']+"\n"+"Cellphone: "+widget.serverDataURL['cellphone'],
              style: TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
