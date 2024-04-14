// ignore_for_file: avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'openai_service.dart';
import 'pallete.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  void speechtoGPT () async {
    setState(() {});
    if (speechToText.isListening) {
      print("waiting to shutup");
      Future.delayed(Duration(milliseconds: 1900), speechtoGPT);
      return;}
    print("i sent --- " + lastWords + " ---- to chat gpt");
    // final speech = lastWords;
    final speech = await openAIService.isArtPromptAPI(lastWords);
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
                    height: 123,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
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
                          ? 'Hello ! \n what can I do for you?'
                          :lastWords,
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
                      generatedContent == null
                          ? ''
                          : generatedContent!,
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
                        child: Image.network(generatedImageUrl == null
                            ? 'https://cdn.discordapp.com/attachments/792029188009361452/1189049370029588562/image.png?ex=65f90885&is=65e69385&hm=58039fa624a4fdb2f8e88ec1dda75b5eb1fb4a6ceedf8dcf7158dfcdb9e54272&'
                            : generatedImageUrl!,),
                      ),
                    ),
                  ],
                ),
              ),

            ),
            if (generatedImageUrl != null)
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 10, left: 22),
                ),
              ),
            ),
            // features list
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        // delay: Duration(milliseconds: start + 3 * delay),
        child: TextButton.icon(
          onPressed: () async {
            if (await speechToText.hasPermission && speechToText.isNotListening) {
              await startListening();
              setState(() {});
            } if (speechToText.isListening) {
              speechtoGPT();
              } else {
                initSpeechToText();
              }


          },
          icon: Icon(speechToText.isListening ? Icons.stop : Icons.mic,),
          label: Text("${speechToText.isListening}"),
        ),
      ),
    );
  }
}
