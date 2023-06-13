import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'gotDetailsBack.dart';
import 'navigationDrawerNew.dart';

class RegistrationScreen extends StatefulWidget {
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? firstNameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
  String? phoneNumberErrorText;

  void validateFields() {
    setState(() {
      firstNameErrorText = firstNameController.text.isEmpty
          ? "Please enter your first name"
          : null;
      lastNameErrorText = lastNameController.text.isEmpty
          ? "Please enter your last name"
          : null;
      emailErrorText =
      emailController.text.isEmpty ? "Please enter your email" : null;
      phoneNumberErrorText = phoneNumberController.text.isEmpty
          ? "Please enter your phone number"
          : null;
    });

    if (firstNameErrorText == null &&
        lastNameErrorText == null &&
        emailErrorText == null &&
        phoneNumberErrorText == null) {
      final data = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'cellphone': phoneNumberController.text
      };
      sendData(data);
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  MobileScannerController cameraController = MobileScannerController();

  @override
  Future<void> sendData(data) async {
    final url = Uri.parse('http://192.168.1.27:3000/user');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Data successfully sent
        print('Data sent successfully');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GotDetailsBack(serverDataURL: jsonDecode(response.body)),
            ));
      } else {
        // Error occurred
        print('Error sending data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Registration Form",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter your first name",
                  errorText: firstNameErrorText,
                ),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter your last name",
                  errorText: lastNameErrorText,
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  errorText: emailErrorText,
                ),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                  errorText: phoneNumberErrorText,
                ),
              ),
              ElevatedButton(
                onPressed: validateFields,
                child: Text("Register Member"),
              ),
            ],
          ),
        ),
      ),
      drawer: NavigationDrawerNew(cameraController: cameraController),
    );
  }
}