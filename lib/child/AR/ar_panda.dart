// ignore_for_file: unused_element, prefer_const_constructors, unnecessary_this, prefer_const_constructors_in_immutables, avoid_print

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class ar_panda extends StatefulWidget {
  // ignore: use_super_parameters
  ar_panda({Key? key}) : super(key: key);
  @override
  _ar_pandaState createState() => _ar_pandaState();
}

class _ar_pandaState extends State<ar_panda> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  ARNode? localObjectNodepanda_excited;
  ARNode? localObjectNodepanda_laugh;
  ARNode? localObjectNodepanda_sad;
  ARNode? localObjectNodepanda_cry;
  ARNode? localObjectNodepanda_mad;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expressions With Pando'),
        ),
        body: Container(
            child: Stack(children: [
              ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: panda_excited,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/Models/panda_excited/jpegmidsmile-01-01-01-01.jpg', // replace this with your image path
                                width: 30, // adjust width as needed
                                height: 30, // adjust height as needed
                              ),
                              // adjust spacing between image and text
                              Text(
                                'Panda Happy',
                                style: TextStyle(
                                    fontSize: 16), // adjust font size as needed
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: panda_laugh,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/Models/panda_laughing/jpegngakak.jpg', // replace this with your image path
                                width: 30, // adjust width as needed
                                height: 30, // adjust height as needed
                              ),
                              // adjust spacing between image and text
                              Text(
                                'Panda Laughing',
                                style: TextStyle(
                                    fontSize: 16), // adjust font size as needed
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: panda_sad,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/Models/panda_sad/no-01.jpg', // replace this with your image path
                                width: 30, // adjust width as needed
                                height: 30, // adjust height as needed
                              ),
                              // adjust spacing between image and text
                              Text(
                                'Panda Afraid',
                                style: TextStyle(
                                    fontSize: 16), // adjust font size as needed
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: panda_cry,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/Models/panda_cry/cry-01.jpg', // replace this with your image path
                                width: 30, // adjust width as needed
                                height: 30, // adjust height as needed
                              ),
                              // adjust spacing between image and text
                              Text(
                                'Panda Cry',
                                style: TextStyle(
                                    fontSize: 16), // adjust font size as needed
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: panda_mad,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/Models/panda_mad/jpegsipit-01-01-01.jpg', // replace this with your image path
                                width: 30, // adjust width as needed
                                height: 30, // adjust height as needed
                              ),
                              // adjust spacing between image and text
                              Text(
                                'Panda Mad',
                                style: TextStyle(
                                    fontSize: 16), // adjust font size as needed
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _removeAllNodes,
                      child: Text('Remove All'),
                    ),
                  ]))
            ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "Images/triangle.png",
      showWorldOrigin: true,
      handleTaps: false,
    );
    this.arObjectManager!.onInitialize();
  }


  Future<void> panda_excited() async {
    if (this.localObjectNodepanda_excited != null) {
      this.arObjectManager!.removeNode(this.localObjectNodepanda_excited!);
      this.localObjectNodepanda_excited = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Models/panda_excited/panda_excited.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNodepanda_excited =
      await this.arObjectManager!.addNode(newNode);
      this.localObjectNodepanda_excited =
      (didAddLocalNodepanda_excited!) ? newNode : null;
    }
  }

  Future<void> panda_laugh() async {
    if (this.localObjectNodepanda_laugh != null) {
      this.arObjectManager!.removeNode(this.localObjectNodepanda_laugh!);
      this.localObjectNodepanda_laugh = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Models/panda_laughing/panda_laugh.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNodepanda_laugh =
      await this.arObjectManager!.addNode(newNode);
      this.localObjectNodepanda_laugh =
      (didAddLocalNodepanda_laugh!) ? newNode : null;
    }
  }

  Future<void> panda_sad() async {
    if (this.localObjectNodepanda_sad != null) {
      this.arObjectManager!.removeNode(this.localObjectNodepanda_sad!);
      this.localObjectNodepanda_sad = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Models/panda_sad/panda_sad.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNodepanda_sad =
      await this.arObjectManager!.addNode(newNode);
      this.localObjectNodepanda_sad =
      (didAddLocalNodepanda_sad!) ? newNode : null;
    }
  }

  Future<void> panda_cry() async {
    if (this.localObjectNodepanda_cry != null) {
      this.arObjectManager!.removeNode(this.localObjectNodepanda_cry!);
      this.localObjectNodepanda_cry = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Models/panda_cry/panda_cry.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNodepanda_cry =
      await this.arObjectManager!.addNode(newNode);
      this.localObjectNodepanda_cry =
      (didAddLocalNodepanda_cry!) ? newNode : null;
    }
  }

  Future<void> panda_mad() async {
    if (this.localObjectNodepanda_mad != null) {
      this.arObjectManager!.removeNode(this.localObjectNodepanda_mad!);
      this.localObjectNodepanda_mad = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Models/panda_mad/panda_mad.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNodepanda_mad =
      await this.arObjectManager!.addNode(newNode);
      this.localObjectNodepanda_mad =
      (didAddLocalNodepanda_mad!) ? newNode : null;
    }
  }

  Future<void> _removeAllNodes() async {

    if (this.localObjectNodepanda_excited != null) {
      await this.arObjectManager!.removeNode(this.localObjectNodepanda_excited!);
      this.localObjectNodepanda_excited = null;
    }
    if (this.localObjectNodepanda_laugh != null) {
      await this.arObjectManager!.removeNode(this.localObjectNodepanda_laugh!);
      this.localObjectNodepanda_laugh = null;
    }
    if (this.localObjectNodepanda_sad != null) {
      await this.arObjectManager!.removeNode(this.localObjectNodepanda_sad!);
      this.localObjectNodepanda_sad = null;
    }
    if (this.localObjectNodepanda_cry != null) {
      await this.arObjectManager!.removeNode(this.localObjectNodepanda_cry!);
      this.localObjectNodepanda_cry = null;
    }
    if (this.localObjectNodepanda_mad != null) {
      await this.arObjectManager!.removeNode(this.localObjectNodepanda_mad!);
      this.localObjectNodepanda_mad = null;
    }
    print('All nodes removed successfully');
  }
}
