// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

class EDchild extends StatefulWidget {
  const EDchild({super.key});

  @override
  State<EDchild> createState() => _EDchildState();
}

class _EDchildState extends State<EDchild> {
  @override
  void initState() {
    main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/childED');
                  },
                  child: Text("ChildED")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
