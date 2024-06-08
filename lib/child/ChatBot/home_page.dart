// ignore_for_file: avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'openai_service.dart';
import 'pallete.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class VChomepage extends StatefulWidget {
  const VChomepage({super.key});

  @override
  State<VChomepage> createState() => _VChomepageState();
}

class _VChomepageState extends State<VChomepage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  void speechtoGPT() async {
    setState(() {});
    if (speechToText.isListening) {
      print("waiting to shutup");
      Future.delayed(Duration(milliseconds: 1900), speechtoGPT);
      return;
    }
    print("i sent --- " + lastWords + " ---- to chat gpt");

    final speech = await openAIService.isArtPromptAPI(lastWords);
    print(speech);
    if (!speech.contains('error')) {
      if (!speech.contains('Error')) {
        saveQuestion(lastWords, speech);
      }
    }
    if (speech.contains('https')) {
      generatedImageUrl = speech;
      generatedContent = null;
      setState(() {});
    } else {
      generatedImageUrl = null;
      generatedContent = speech;
      setState(() {});
      await systemSpeak(speech);
    }
  }

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setVoice({"name": "en-us-x-iol-network", "locale": "en-US"});
    await flutterTts.setPitch(1.25); // Higher pitch for a cartoon-like voice
    await flutterTts.setSpeechRate(0.4); // Slower rate to be more child-friendly
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          child: const Text('Fuzzy Fizzie'),
        ),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // virtual assistant picture
            ZoomIn(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle ,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/virtualAssistant.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // chat bubble

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text("Your Request"),
                    Text(
                      lastWords == ""
                          ? 'Hello We are Fuzzy and Fizzle ! \n what can we do for you? \n we can answer any question ! \n we can draw any picture !'
                          : lastWords,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null ? 25 : 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text("Answer: "),
                    Text(
                      generatedContent == null ? '' : generatedContent!,
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null ? 25 : 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          generatedImageUrl == null
                              ? 'https://cdn.discordapp.com/attachments/792029188009361452/1189049370029588562/image.png?ex=66652385&is=6663d205&hm=f0a5d139789a7a0cbb4830bb51c0688cb53d017daadac2037ff85e4248672720&'
                              : generatedImageUrl!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (generatedImageUrl != null)
              SlideInLeft(
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 22),
                  ),
                ),
              ),
            // features list
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'I can draw or answer any question...',
                        border: OutlineInputBorder(),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: () async {
                            if (await speechToText.hasPermission &&
                                speechToText.isNotListening) {
                              await startListening();
                              setState(() {});
                            }
                            if (speechToText.isListening) {
                              speechtoGPT();
                            } else {
                              initSpeechToText();
                            }
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.arrow_forward_sharp),
                          onPressed: () {
                            speechtoGPT();
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          lastWords = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void saveQuestion(String question, String answer) async {
  // Path to a directory where the app may place data that is user-generated
  //final directory = await getApplicationDocumentsDirectory();

  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/chat_history.txt');

    final now = DateTime.now();
    final formattedDate = '${now.hour}:${now.minute}:${now.second} '
        ''
        ''
        ' ${now.day}/${now.month}/${now.year}'; // Time followed by date
    final text = '$formattedDate*$question*$answer\n';

    if (!await file.exists()) {
      await file.writeAsString(text);
    } else {
      await file.writeAsString(text, mode: FileMode.append);
    }
    print("\n$text\n");
    print("\nsaved to ${directory.path}\n");
  } on PlatformException catch (e) {
    print(e);
  }
}
