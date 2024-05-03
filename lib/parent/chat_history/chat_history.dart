import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

////////////////////////////////////////////////////////////////////////////////
class chat_history extends StatefulWidget {
  const chat_history({Key? key}) : super(key: key);

  @override
  _chat_historyState createState() => _chat_historyState();
}

class _chat_historyState extends State<chat_history> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scores',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.amber[600],
      ),
      backgroundColor: Colors.amber[400],

      body: FutureBuilder<String>(
        future: readScores(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  // 'Error: ${snapshot.error}',
                  'No scores yet.',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                  ),
                ),
              );
            } else if (snapshot.data!.isEmpty){
              return const Text(
                'No scores yet.',
                style: TextStyle(
                    color: Colors.teal
                ),
              );
            }
            else {
              return ListView(
                children: snapshot.data!.split('\n').map((line) {
                  final parts = line.split('*');
                  if (parts.length < 3) return Container(); // Skip malformed lines
                  final date = parts[0];
                  final question = parts[1];
                  final answer = parts[2];
                  return ListTile(
                    title: Text('Date: $date'),
                    subtitle: answer.startsWith('http') ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the URL when the image is tapped
                            launch(answer);
                          },
                          child: Image.network(
                            answer,
                            width: 100, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between image and text
                        Flexible(
                          child: Text(
                            'User Request: $question\nBot Response: $answer',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ) : // Display image if answer is a URL
                    Text('User Request: $question\nBot Response: $answer'), // Display text otherwise
                  );


                }).toList(),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await clearScores(); // Clear the scores
          setState(() {}); // Refresh the page
        },
        child: Icon(
          Icons.delete,
          color: Colors.amber[900],
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Future<String> readScores() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/chat_history.txt');
    return file.readAsString();
  }
}

Future<void> clearScores() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/chat_history.txt');
  if (await file.exists()) {
    await file.delete();
  }
}

////////////////////////////////////////////////////////////////////////////////

