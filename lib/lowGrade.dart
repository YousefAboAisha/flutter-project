import 'package:flutter/material.dart';

class LowGrade extends StatelessWidget {
  const LowGrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz app'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                "Oops!",
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            Image.asset('images/fail.png'),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: const Text(
                "Your scroe is 2 / 10",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: const Text("Sorry, better luck next time!"),
            ),
            SizedBox(
              width: 200,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 24)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ))),
                  onPressed: () => {},
                  child: const Text(
                    "Back to home",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
