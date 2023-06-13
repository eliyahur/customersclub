import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'foundCodeScreen.dart';
import 'navigationDrawerNew.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  late BuildContext context;
  bool _screenOpened = false;

  // @override
  // void initState() {
  // cameraController = MobileScannerController(
  //   detectionSpeed: DetectionSpeed.noDuplicates,
  //   facing: CameraFacing.back,
  //   torchEnabled: false,
  // );
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }
  // @override
  // void dispose() {
  // cameraController.stop();
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print('state = $state');
  // }
  _foundBarCode(BarcodeCapture caught, BuildContext context) {
    if (!_screenOpened) {
      final List<Object?> code = caught.raw ?? "something something";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FoundCodeScreen(screenClosed: _screenWasClosed, value: code),
          ));
    }
  }

  _screenWasClosed() {
    _screenOpened = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Club App'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.grey);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      drawer: NavigationDrawerNew(cameraController: cameraController),
      body: MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            _foundBarCode(capture, context);
          }),
    );
  }
}