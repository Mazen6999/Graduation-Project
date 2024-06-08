// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PRfeatures extends StatefulWidget {
  const PRfeatures({super.key});

  @override
  State<PRfeatures> createState() => _PRfeaturesState();
}

class _PRfeaturesState extends State<PRfeatures> {
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
                Navigator.pushNamed(context, '/chat_history');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Chat bot History", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mcq_history');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("MCQ Scores", style: TextStyle(color: Colors.black, fontSize: 24,),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
