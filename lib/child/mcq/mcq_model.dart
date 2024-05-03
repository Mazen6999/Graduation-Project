import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';


List<Question> question_set = question_pack_1;

class Question {
  final String text;
  final String image_location ;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    required this.image_location,
    this.isLocked = false,
    this.selectedOption,
  });
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to the Quiz',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.amber[600],
      ),
      backgroundColor: Colors.amber[400] ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],

              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Play',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 40,
                  ),

                ),
              ),
              onPressed: () {
                question_set = question_pack_1;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PackSelectionPage()),
                );
              },
            ),
            const SizedBox(height: 200,),
          ],
        ),
      ),
    );
  }
}


class PackSelectionPage extends StatefulWidget {
  const PackSelectionPage({Key? key}) : super(key: key);

  @override
  _PackSelectionPageState createState() {
    print("hereeeeeeeeeeeeeeeeeee");
    resetQuiz();
   return _PackSelectionPageState();
  }

}



class _PackSelectionPageState extends State<PackSelectionPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("entered this function");
    resetQuiz(); // Reset the quiz whenever the dependencies change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a level',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.amber[600],
      ),
      backgroundColor: Colors.amber[400] ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[300],
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Level 1',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 30,
                    ),

                ),
              ),
              onPressed: () {
                resetQuiz();
                question_set = question_pack_1;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  QuestionWidget()),
                );
              },
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
              child:  const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Level 2',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                  ),

                ),
              ),
              onPressed: () {
                resetQuiz();
                question_set = question_pack_2;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  QuestionWidget()),
                );
              },
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
              child:  const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Emoji Level',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                  ),

                ),
              ),
              onPressed: () {
                resetQuiz();
                question_set = question_pack_3;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestionWidget()),
                );
              },
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[300],
              ),
              child:  const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cartoon Level',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                  ),

                ),
              ),
              onPressed: () {
                resetQuiz();
                question_set = question_pack_4;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestionWidget()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




////////////////////////////////////////////////////////////////////////////////

class QuestionWidget extends StatefulWidget{
  const QuestionWidget({
    Key? key,
  }) : super(key:key);

  @override
  State<QuestionWidget> createState()=>_QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget>{

  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;


  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.amber[400],
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              const SizedBox(height: 32),
              Text(
                  "Question $_questionNumber/${question_set.length}",
                  style: TextStyle(
                    color: Colors.teal.shade900,
                  ),
              ),
              const Divider(thickness: 1,color: Colors.brown,),

              Expanded(
                //shows questions after one another
                  child: PageView.builder(
                    itemCount: question_set.length,
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      final _question = question_set[index];
                      return buildQuestion(_question);
                    },
                  ),
              ),
              _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
              const SizedBox(height: 20,),

            ],
          ),
      ),
    );
  }


  Column buildQuestion(Question question){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 32),
        Text(
          question.text,
          style: const TextStyle(
              fontSize: 25,
              fontFamily: "Arial",
              color: Colors.teal,
              fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Center(
          child: Container(
            width: 250,
            height: 230,
            child: Image(
              image:AssetImage(question.image_location),
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Expanded(
          child:OptionsWidget(
            question: question,
            onClickedOption: (option){
              if(question.isLocked){
                return;
              }else{
                setState((){
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if(question.selectedOption!.isCorrect){
                  _score++;
                }
              }
            },
          ),
        ),


      ],
    );
  }

  ElevatedButton buildElevatedButton(){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[300],
        ),
        onPressed: (){
          if (_questionNumber < question_set.length){
            _controller.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInExpo,
            );
            setState(() {
              _questionNumber++;
              _isLocked=false;
            });
          }else{
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder:(context)=> ResultPage(score:_score) ));

          }


        },
        child: Text(
          _questionNumber < question_set.length ? "Next page" : "See the result",
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
    );

  }

////////////////////////////////////////////////////////////////////////////////

}

class Option {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });
}



class OptionsWidget extends StatelessWidget{

  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,

  }) : super(key:key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: question.options
            .map((option) => buildOption(context,option))
            .toList(),
    ),
  );

  Widget buildOption(BuildContext context , Option option){

    final color = getColorForOption(option,question);

    return GestureDetector(

      onTap: () => onClickedOption(option),

      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin:  const EdgeInsets.symmetric(vertical: 8),
      
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.text,
              style: const TextStyle(fontSize: 15),
            ),
            getIconForOption(option,question)
          ],
        ),
      ),
    );
  }

  Color getColorForOption(Option option , Question question){
    final isSelected = option == question.selectedOption;
    if(question.isLocked){
      if(isSelected){
        return option.isCorrect ? Colors.green : Colors.red;
      }else if (option.isCorrect){
        return Colors.lightGreenAccent.shade700;
      }
    }
    return Colors.grey.shade700;
    //return Colors.orange.shade400;
  }

  Widget getIconForOption(Option option , Question question){

    final isSelected = option == question.selectedOption;
    if (question.isLocked){
      if(isSelected){
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.lightGreenAccent)
            : const Icon(Icons.cancel, color: Colors.red);
      }else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.lightGreenAccent);
      }
    }
    return const SizedBox.shrink();
  }
}

////////////////////////////////////////////////////////////////////////////////
class ResultPage extends StatelessWidget{

  const ResultPage ({Key? key , required this.score}) : super(key : key);
  final int score;

  @override
  Widget build(BuildContext context){
    saveScore(score);
    return Scaffold(
      backgroundColor: Colors.amber[400],
      body: Column(
        children: [

          const SizedBox(height: 100,),
          Icon(
            Icons.sports_score_rounded,
            color: Colors.amber[800],
            size: 200,
          ),
          Center(
            child: Text(
              "You got $score/${question_set.length}\n",
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.teal,
                  )
            ),
          ),
          Center(
            child: Text(
                    "${getScoreMessage(score, question_set.length)}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                )

            ),

          ),
          const SizedBox(height: 200,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[300],
            ),
            child: const Text(
              'Play Again',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),

            onPressed: () {
              resetQuiz();
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      ),

    );
  }
}


String getScoreMessage(int score, int questionLength) {
  final double scorePercentage = score / questionLength;

  if (scorePercentage == 1.0) {
    return "Well Done!";
  } else if (scorePercentage >= 0.8) {
    return "Good Job!";
  } else if (scorePercentage >= 0.6) {
    return "Great!";
  } else if (scorePercentage >= 0.5) {
    return "Good!";
  } else if (scorePercentage >= 0.2) {
    return "We can do better!";
  } else {
    return "Lets Try again";
  }
}

String getLevelName() {

  if (question_set == question_pack_1) {
    return "Level 1";
  } else if (question_set == question_pack_2) {
    return "Level 2";
  } else if (question_set == question_pack_3) {
    return "Emoji Level";
  } else if (question_set == question_pack_4) {
    return "Cartoon Level";
  }else{
    return "";
  }
}

// this function stores the score in file
void saveScore(int score) async {

  // Path to a directory where the app may place data that is user-generated
  //final directory = await getApplicationDocumentsDirectory();

  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/mcq_scores.txt');

    final now = DateTime.now();
    final formattedDate = '${now.hour}:${now.minute}:${now.second} ' '' '' ' ${now.day}/${now.month}/${now.year}'; // Time followed by date
    final text = '$formattedDate%${getLevelName()}%$score/${question_set.length}\n';


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

void resetQuiz() {

  for (var question in question_set) {
    //print("resetting question");
    question.isLocked = false;
    question.selectedOption = null;
    question.selectedOption = null;
  }
}

////////////////////////////////////////////////////////////////////////////////
final question_pack_1 = [

  Question(
    text: "How do these girls look ?",
    image_location: "assets/mcq_emotions/pack1/happy.jpg",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "Scared", isCorrect: false),
      const Option(text: "surprised", isCorrect: false),
    ] ,
  ),


  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack1/sad.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: true),
      const Option(text: "surprised", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack1/angry.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "angry", isCorrect: true),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack1/scared.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "scared", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack1/surprised.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "surprised", isCorrect: true),
      const Option(text: "scared", isCorrect: false),
    ] ,
  ),
];

final question_pack_2 = [

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/happy.jpg",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/confused.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: true),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/angry.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "angry", isCorrect: true),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/sad.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: true),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/scared.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "Sad", isCorrect: false),
      const Option(text: "scared", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that girl look ?",
    image_location: "assets/mcq_emotions/pack2/surprised.jpg",
    options:[
      const Option(text: "angry", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "surprised", isCorrect: true),
    ] ,
  ),

];

//emoji level
final question_pack_3 = [

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/sad.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/angry.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: true),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/happy.png",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/happy2.png",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "surprised", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "scared", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/sad2.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/surprised.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "surprised", isCorrect: true),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/sad3.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "surprised", isCorrect: false),
      const Option(text: "sad", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that emoji look ?",
    image_location: "assets/mcq_emotions/pack3/angry2.png",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: true),
    ] ,
  ),

];

//cartoon level
final question_pack_4 = [

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/sad.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: true),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/happy.jpg",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "scared", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/happy2.jpg",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/surprised.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "surprised", isCorrect: true),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/angry.jpg",
    options:[
      const Option(text: "Happy", isCorrect: false),
      const Option(text: "surprised", isCorrect: false),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "angry", isCorrect: true),
    ] ,
  ),

  Question(
    text: "How does that boy look ?",
    image_location: "assets/mcq_emotions/pack4/happy3.jpg",
    options:[
      const Option(text: "Happy", isCorrect: true),
      const Option(text: "confused", isCorrect: false),
      const Option(text: "sad", isCorrect: false),
      const Option(text: "angry", isCorrect: false),
    ] ,
  ),

];
