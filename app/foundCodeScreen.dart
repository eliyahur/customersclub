import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoundCodeScreen extends StatefulWidget {
  final List<Object?> value;
  final Function() screenClosed;

  const FoundCodeScreen(
      {Key? key, required this.screenClosed, required this.value})
      : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  late Future<dynamic> _data;

  @override
  void initState() {
    super.initState();
    _data = _updateBeerNumber();
  }

  Future<dynamic> _updateBeerNumber() async {
    final url = Uri.parse('http://192.168.1.27:3000/addbeer');
    var myMap = widget.value[0];
    myMap = (myMap as Map<dynamic, dynamic>)['rawValue'];
    print(myMap);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'userId': myMap}),
      );
      if (response.statusCode == 200) {
        // Data successfully sent
        print('Data sent successfully');
        return jsonDecode(response.body);
      } else {
        // Error occurred
        print('Error sending data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found Code'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final int beers = snapshot.data['beers'];
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total beers "+snapshot.data['firstName']+" drank:",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      beers.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
