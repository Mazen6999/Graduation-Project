// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'PRorCH.dart';
import 'child/ChatBot/home_page.dart';
import 'child/EDgoogleML/EDmain.dart';
import 'child/EDgoogleML/home.dart';
import 'child/index.dart';
import 'child/mcq/mcq_model.dart';


void main() => runApp(MaterialApp(
  // home: Home(),
  initialRoute: '/',
  routes: {
    '/': (context)=> PRorCh(),
    '/ch_index': (context)=> Chfeatures(),
    '/vchome': (context)=> VChomepage(),
    '/EDchild': (context)=> EDchild(),
    '/childED': (context)=> childED(),
    '/mcq': (context)=> FirstPage(),
    // '/location': (context)=> ChooseLocation()

  },
));