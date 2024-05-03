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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat_history');
                  },
                  child: Text("history of Questions asked to chatbot")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mcq_history');
                  },
                  child: Text("mcq scores")
              ),


            ],
          ),
        ),
      ),
    );
  }
}
