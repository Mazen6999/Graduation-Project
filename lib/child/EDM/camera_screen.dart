import 'package:flutter/material.dart';
import 'top_image_viewer.dart';
import 'camera_viewer.dart';
import 'capture_button.dart';
import 'scan_controller.dart'; // Import scan_controller.dart (if necessary)
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanController = Get.find<ScanController>(); // Get the ScanController

    return Stack(
      alignment: Alignment.center, // Re-introduce Stack for centering
      children: [
        Positioned(
          top: 175.0, // Adjust the value for desired position
          left: 0,
          right: 0,
          child: Center( // Add Center widget for vertical centering
            child: Obx( // Wrap the text widget with Obx for reactivity
                  () => Text(
                scanController.latestLabel.isEmpty // Check if empty using isEmpty
                    ? "Press the Camera button to get started"
                    : "Try the ${scanController.latestLabel} emotion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0, // Adjust font size for desired size
                ),
              ),
            ),
          ),
        ),
        CameraViewer(),
        CaptureButton(),
        TopImageViewer()
      ],
    );
  }
}