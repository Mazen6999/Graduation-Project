import 'package:flutter/material.dart';
import 'scan_controller.dart';
import 'package:get/get.dart';

class TopImageViewer extends StatelessWidget {
  const TopImageViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(
        builder: (controller) =>
            Positioned(
              top: 50,
              left: 0,
              child: SizedBox(
                height: 100,
                width: Get.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.imageList.length,
                    itemBuilder: (context, index) {
                      final String resultText =
                      controller.resultList.length > index
                          ? controller.resultList[index] ?? ""
                          : "";
                      final String answerText =
                      controller.answersList.length > index
                          ? controller.answersList[index] ?? ""
                          : "";

                      Color textColor = Colors.red;
                      if (resultText == answerText) {
                        textColor = Colors.green;
                      }

                      return SizedBox(
                          height: 100,
                          width: 75,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: RepaintBoundary(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(
                                                controller.imageList[index]),
                                          ),
                                        )),
                                  )),
                              Positioned(
                                bottom: 5.0, // Adjust text position
                                right: 5.0, // Adjust text position
                                child: Text(
                                  resultText,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 12.0),
                                ),
                              )
                            ],
                          ));
                    }),
              ),
            ));
  }
}