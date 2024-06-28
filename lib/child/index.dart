// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Chfeatures extends StatefulWidget {
  const Chfeatures({super.key});

  @override
  State<Chfeatures> createState() => _ChfeaturesState();
}

class _ChfeaturesState extends State<Chfeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vchome');
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Chat Bot", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/EDchild');
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Google Emotion Detector", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mcq');
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("MCQ Quiz", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ar_index');
                },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("AR", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adhamEDM');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("ML Emotion Detector", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
