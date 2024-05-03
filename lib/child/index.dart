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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vchome');
                  },
                  child: Text("ChatBot")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/EDchild');
                  },
                  child: Text("Emotion detector")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mcq');
                  },
                  child: Text("mcq")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ar_index');
                  },
                  child: Text("AR")
              ),

            ],
          ),
        ),
      ),
    );
  }
}
