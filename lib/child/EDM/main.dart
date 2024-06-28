import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'camera_viewer.dart';
import 'global_bindings.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';

//void main() {
  //runApp(const MyApp());
//}

class adhamED extends StatelessWidget {
  const adhamED({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      title: "Camera Application",
      home: const CameraScreen(),
    );


  }
}
