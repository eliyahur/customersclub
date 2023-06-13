import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import './myHomePage.dart';
import './registrationScreen.dart';

class NavigationDrawerNew extends StatefulWidget {
  final MobileScannerController cameraController;

  const NavigationDrawerNew({Key? key, required this.cameraController})
      : super(key: key);

  @override
  State<NavigationDrawerNew> createState() => _NavigationDrawerNew();
}

class _NavigationDrawerNew extends State<NavigationDrawerNew> {
  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ));

  Widget buildMenuItems(BuildContext context) => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.scanner_outlined),
        title: const Text('Scan Barcode'),
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context)=> MyHomePage(),

          // ));
          // Navigator.of(context).pop();
          widget.cameraController.stop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.app_registration_outlined),
        title: const Text('New Members Registration'),
        onTap: () {
          widget.cameraController.stop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegistrationScreen()));
        },
      ),
    ],
  );
}