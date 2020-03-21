import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

main() => runApp(CameraApp());

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription> cameras;
  CameraController controller;
  Future<void> futureInit;

  void carregarCamaras() async {
    cameras = await availableCameras();
    print(cameras);
    controller = CameraController(cameras.first, ResolutionPreset.ultraHigh);
    futureInit = controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    carregarCamaras();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return CameraPreview(controller);
          else
            return Center(child: CircularProgressIndicator());
        });
  }
}
