import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imglib;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;




class ScanController extends GetxController {



  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  final RxBool _isInitialized = RxBool(false);
  CameraImage? _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);
  final RxList<String?> _resultList = RxList<String?>([]); // Private list
  List<String?> get resultList => _resultList.toList(); // Public getter

  final RxList<String?> _answersList = RxList<String?>([]); // Private list
  List<String?> get answersList => _answersList.toList(); // Public getter

  final RxString _latestLabel = RxString(""); // New RxString for the latest label

  String get latestLabel => _latestLabel.value; // Public getter for the RxString




  final RxString _myString = RxString("");

  String get myString => _myString.value;

  void setMyString(String value) {
    _myString.value = value;
  }





  int _imageCount=0;
  int _labelflag=0;
  List<String> _randomLabels = [];

  CameraController get cameraController => _cameraController;
  bool get isInitialized => _isInitialized.value;
  List<Uint8List> get imageList => _imageList;


  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }




  String getRandomString(List<String> stringList) {
    if (stringList.isEmpty) {
      throw Exception("List cannot be empty");
    }
    final random = Random();
    final index = random.nextInt(stringList.length);
    return stringList[index];
  }


  Future<void> _initTensorFlow() async {
    String? res = await Tflite.loadModel(
        model: "assets/converted_model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[1],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await _cameraController.initialize();
    _isInitialized.value = true;

    _cameraController.startImageStream((image) {
      _imageCount++;
      _cameraImage=image;
      if (_imageCount % 30 == 0) {
        _imageCount = 0;
       // _objectRecognition(image);
      }
    });
  }

  @override
  void onInit() {
    initCamera();
    _initTensorFlow();
    super.onInit();
  }


  Future<String?> _objectRecognition(CameraImage? cameraImage) async {
    if (cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane) {return plane.bytes;}).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,   // defaults to 127.5
          imageStd: 127.5,    // defaults to 127.5
          rotation: 90,       // defaults to 90, Android only
          numResults: 100,
          threshold: 0.000000000000001,     // defaults to 0.1
          asynch: true        // defaults to true
      );
      //print("\n");
      int? maybeNumber = recognitions?.length;
      int definiteNumber = maybeNumber!;
      String result=recognitions?[0]['label'];
      result=extractLabel(result);
      String temp;
      double highest = 0;
      //recognitions?[2]['confidence']=5.0;

        if(_labelflag==0) {
          for (int i=0; i<definiteNumber; i++) {
          temp = recognitions?[i]['label'];
          temp=extractLabel(temp);
          _randomLabels.add(temp);
          //print(temp);
         // print(_randomLabels);
        }
          _labelflag=1;}
        else {
          for (int i=0; i<definiteNumber; i++) {
          if (recognitions?[i]['confidence'] > highest) {
            highest = recognitions?[i]['confidence'];
            result = recognitions?[i]['label'];
            result = extractLabel(result);
            //print(highest);
            // print(result);
          }
        }//print(recognitions);
          return result; }
    }

   return null;
  }

  /*
  Future<void> _objectRecognition(String filepath) async {
    var recognitions = await Tflite.runModelOnImage(
        path: filepath,   // required
        imageMean: 0.0,   // defaults to 117.0
        imageStd: 255.0,  // defaults to 1.0
        numResults: 2,    // defaults to 5
        threshold: 0.2,   // defaults to 0.1
        asynch: true      // defaults to true
    );
    print(recognitions);
  }
  */

  String extractLabel(String inputString) {
    // Split the string using space as the delimiter
    List<String> parts = inputString.split(' ');

    // Check if there are at least two elements (index 0 and 1)
    if (parts.length >= 2) {
      // Return the second element (index 1)
      return parts[1];
    } else {
      // Return an empty string if there are less than two elements
      return "";
    }
  }

  imglib.Image _convertYUV420toImageColor(CameraImage? image) {
    const shift = (0xFF << 24);

    final int width = image!.width;
    final int height = image!.height;
    final int uvRowStride = image!.planes[1].bytesPerRow;
    final int uvPixelStride = image!.planes[1].bytesPerPixel!;

    final img = imglib.Image(height, width); // Create Image buffer

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;

        final yp = image!.planes[0].bytes[index];
        final up = image!.planes[1].bytes[uvIndex];
        final vp = image!.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        if (img.boundsSafe(height - y, x)) {
          img.setPixelRgba(height - y, x, r, g, b, shift);
        }
      }
    }

    return img;
  }


  imglib.Image rotateImage180Degrees(imglib.Image image) {
    final int width = image.width;
    final int height = image.height;

    final img = imglib.Image(width, height); // Create Image buffer

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int newX =x; // don't reverse the x coordinates
        final int newY = height - y - 1; // Reverse the y-coordinate

        img.setPixel(x, y, image.getPixel(newX, newY));
      }
    }

    return img;
  }





  void capture() async {

       if (_cameraImage != null) {
         try {
           //imglib.Image image = imglib.Image.fromBytes(
              // _cameraImage!.width, _cameraImage!.height,
              // _cameraImage!.planes[0].bytes, format: imglib.Format.bgra);
           // Call object recognition on the _cameraImage directly

            imglib.Image imagePng=_convertYUV420toImageColor(_cameraImage);
             imagePng=rotateImage180Degrees(imagePng);
           Uint8List bytes = Uint8List.fromList(imglib.encodePng(imagePng));
            String? result = await _objectRecognition(_cameraImage);
           // Create a unique filename for the image
             //String filename = '${DateTime
             //    .now()
              //   .millisecondsSinceEpoch}.jpg';
             // Create a reference to the directory where you want to save the image
           //  Directory appDirectory = await getApplicationDocumentsDirectory();
             // Create the full path for the image file
            // File imageFile = File('${appDirectory.path}/$filename');
             // Write the image bytes to the file
            // await imageFile.writeAsBytes(bytes);
             //print('Image saved to: ${imageFile.path}'); // Log a success message
             //print(result);
           String randomString=getRandomString(_randomLabels);
           _latestLabel.value = randomString;
           _answersList.add(randomString);
           _latestLabel.refresh();
           if(result!=null) {
             _imageList.add(bytes); // Add the image bytes to your list
             _resultList.add(result);
             _resultList.refresh();
             _imageList.refresh();
           }



         } catch (e) {
           print('Error saving image: $e'); // Log any errors
         }
       }

  }

}


