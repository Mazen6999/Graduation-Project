import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';


////////////////////////////////////////////////////////////////////////////////
class mcq_history extends StatefulWidget {
  const mcq_history({Key? key}) : super(key: key);

  @override
  _mcq_historyState createState() => _mcq_historyState();
}

class _mcq_historyState extends State<mcq_history> {

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
                  final parts = line.split('%');
                  if (parts.length < 3) return Container(); // Skip malformed lines
                  final date = parts[0];
                  final levelName = parts[1];
                  final score = parts[2];
                  return ListTile(
                    title: Text('Date: $date'),
                    subtitle: Text('Level Name: $levelName\nScore: $score'),
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
    final file = File('${directory.path}/mcq_scores.txt');
    return file.readAsString();
  }
}

Future<void> clearScores() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/mcq_scores.txt');
  if (await file.exists()) {
    await file.delete();
  }
}

////////////////////////////////////////////////////////////////////////////////

