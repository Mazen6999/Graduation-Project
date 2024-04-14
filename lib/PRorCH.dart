// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PRorCh extends StatefulWidget {
  const PRorCh({super.key});

  @override
  State<PRorCh> createState() => _PRorChState();
}

class _PRorChState extends State<PRorCh> {
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
                  onPressed: () async{
                    Navigator.pushNamed(context, '/ch_index');
                  }, 
                  child: Text("Child ?")
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
