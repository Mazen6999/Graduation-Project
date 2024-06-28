// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'PRorCH.dart';

import 'child/index.dart';

import 'child/ChatBot/home_page.dart';

import 'child/EDgoogleML/EDmain.dart';
import 'child/EDgoogleML/home.dart';

import 'child/mcq/mcq_model.dart';

import 'child/AR/ar_index.dart';
import 'child/AR/ar_panda.dart';
import 'child/AR/objectgesturesexample.dart';

//

import 'parent/index.dart';

import 'parent/mcq_history/mcq_history.dart';
import 'parent/chat_history/chat_history.dart';
import 'child/EDM/main.dart';


void main() => runApp(MaterialApp(
  // home: Home(),
  initialRoute: '/',
  routes: {
    '/': (context)=> PRorCh(),

    '/ch_index': (context)=> Chfeatures(), //index inside child folder

    '/vchome': (context)=> VChomepage(), //  chatbot home page

    '/EDchild': (context)=> EDchild(), // child emotion detector MAIN
    '/childED': (context)=> childED(), //child emotion detector

    '/mcq': (context)=> FirstPage(), // mcq test

    '/ar_index': (context)=> ar_index(), // ar
    '/ar_panda': (context)=> ar_panda(), // ar
    '/ar_monkey': (context)=> ObjectGesturesWidget(), // ar
    // '/location': (context)=> ChooseLocation()

    '/parent_index': (context)=> PRfeatures(),

    '/chat_history': (context)=> chat_history(),
    '/mcq_history': (context)=> mcq_history(),
    '/adhamEDM': (context)=> adhamED(),


  },
));