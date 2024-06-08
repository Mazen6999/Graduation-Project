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
    const bgImg = 'assets/PRorCH/question.jpg';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Mode Selection"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(bgImg),
                fit: BoxFit.fill
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 30),
          child: Column(
            children: [
              SizedBox(height: 75,),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        Navigator.pushNamed(context, '/ch_index');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Play Time", style: TextStyle(color: Colors.black, fontSize: 24), ),
                      ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      Navigator.pushNamed(context, '/parent_index');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Parent Mode", style: TextStyle(color: Colors.black, fontSize: 24), ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
