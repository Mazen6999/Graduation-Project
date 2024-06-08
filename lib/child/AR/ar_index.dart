
import 'package:flutter/material.dart';





class ar_index extends StatefulWidget {
  const ar_index({super.key});

  @override
  State<ar_index> createState() => _ar_indexState();
}

class _ar_indexState extends State<ar_index> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Align(
        alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ar_panda');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
                  child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Learn emotions with pando", style: TextStyle(color: Colors.black, fontSize: 24,),)
                  )
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ar_monkey');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,),
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Play with pandos!", style: TextStyle(color: Colors.black, fontSize: 24,),)
                ),
              ),
            ],
          ),
      ),
    );
  }
}
