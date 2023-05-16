import 'package:flutter/material.dart';
import 'package:flutter_application_1/addQuestion.dart';
import 'package:flutter_application_1/quizes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Quiz app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width *
            0.80, // 80% of screen will be occupied
        elevation: 25,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Yousef Abo Aisha",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                "yousef.aboesha@hotmail.com",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              decoration: BoxDecoration(color: Colors.teal),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                child: Text(
                  "Y",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Create quiz"),
                onTap: () => {
                      Navigator.pop(context), // Close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddQuestion()),
                      ),
                    }),
            const ListTile(
              leading: Icon(Icons.quiz),
              title: Text("Contact Us"),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/quiz.png'),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 24)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ))),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quizes()),
                ),
                child: const Text(
                  "Let's start!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
