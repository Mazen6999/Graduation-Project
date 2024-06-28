import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'scan_controller.dart';
import 'package:get/get.dart';

class CameraViewer extends GetView<ScanController> {
  const CameraViewer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(builder: (controller) {
      if (!controller.isInitialized) {
        return Container();
      }
      return ClipPath(
        clipper: MyCustomClipper(),
        child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: CameraPreview(controller.cameraController)),
      );
    });
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  final double cutoutHeight = 200.0;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, cutoutHeight); // Start from cutout bottom
    path.lineTo(size.width, cutoutHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close(); // Close the path explicitly
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


