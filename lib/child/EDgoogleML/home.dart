// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'EDmain.dart';
import 'package:face_emotion_detector/face_emotion_detector.dart';


class childED extends StatefulWidget {
  const childED({super.key});

  @override
  State<childED> createState() => _childEDState();
}

class _childEDState extends State<childED> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  int i = 1; //camera control

  @override
  void initState() {
    super.initState();
    loadCamera(i);
  }

  loadCamera(int i) {
    cameraController = CameraController(cameras![i], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            smile_and_sleep_detect_google_ML();
          });
        });
      }
    });
  }

  smile_and_sleep_detect_google_ML() async {
    // 1. Capture the image:
    Future<XFile> faceImage = cameraController!.takePicture();
    // 2. Get the image file path:
    String imagePath = await faceImage.then((file) => file.path);
    // 3. Create a File object from the path:
    File photoAsFile = File(imagePath);
    // 4. Use the EmotionDetector:
    EmotionDetector emotionDetector = EmotionDetector();
    var feeling =
    await emotionDetector.detectEmotionFromImage(image: photoAsFile);
    // 5. Assign the output (avoiding null assertion):
    setState(() {
      output = feeling!;
    }); // Handle potential null value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Emotion Detection'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),
              ),
            ),
          ),
          Text(
            output,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      ),
      floatingActionButton: TextButton.icon(
          onPressed: () {
            if (i == 0) {
              i = 1;
            } else {
              i = 0;
            } //swap camera
            loadCamera(i);
          },
          icon: Icon(Icons.switch_camera),
          label: Text("$i")),
    );
  }
}
