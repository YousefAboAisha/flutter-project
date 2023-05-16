import 'package:flutter/material.dart';
import 'package:flutter_application_1/addQuestion.dart';
import 'package:flutter_application_1/faq.dart';
import 'package:flutter_application_1/highGrade.dart';
import 'package:flutter_application_1/lowGrade.dart';
import 'package:flutter_application_1/quizesList.dart';
import 'package:flutter_application_1/services/sqlite_service.dart';

class Quizes extends StatefulWidget {
  const Quizes({Key? key}) : super(key: key);

  @override
  _QuizesState createState() => _QuizesState();
}

class _QuizesState extends State<Quizes> {
  List<QuizQuestion> questions = [];
  List<bool> result = [];
  bool isLoading = true;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _refreshQuestions();
  }

  Future<List<QuizQuestion>> _getQuestions() async {
    final data = await SqliteService().getQuestions();
    return data;
  }

  Future<void> _deleteQuestion(int id) async {
    await SqliteService().deleteQuestion(id);
    _refreshQuestions();
    print("Question has been deleted successfully");
  }

  Future<void> _refreshQuestions() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    // Fetch data from the database
    final data = await _getQuestions();

    // Update state with the new data
    setState(() {
      questions = data;
      result = List.filled(data.length, false, growable: true);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz app'),
      ),
      body: questions.length < 5
          ? const Faq()
          : Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 24)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddQuestion()),
                      ),
                      child: const Text(
                        "Add question",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final QuizQuestion data = questions[index];
                          final String question = data.title;
                          final List<String> options = data.answers;
                          final int? id = data.id;
                          final int correctAnswerIndex =
                              data.correctAnswerIndex;
                          int numberOfQuestions = questions.length;
                          bool isCorrect = false;

                          return Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(75, 158, 158, 158),
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(12),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Q${index + 1}) ",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "$question?",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 213, 63, 63),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Container(
                                                  width: 250.0,
                                                  height: 150.0,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Delete question',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16),
                                                        child: const Text(
                                                          'Are you sure you want to delete this question?',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      115,
                                                                      115,
                                                                      115),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          115,
                                                                          115,
                                                                          115)),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () => {
                                                              _deleteQuestion(
                                                                  id!),
                                                              Navigator.pop(
                                                                  context),
                                                            },
                                                            child: const Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                QuizesList(
                                    options: options,
                                    correctAnswerIndex: correctAnswerIndex,
                                    numberOfQuestions: numberOfQuestions,
                                    score: _score,
                                    isCorrect: isCorrect,
                                    result: result,
                                    id: index),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 24)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                      onPressed: () {
                        result.forEach((element) {
                          if (element == true) {
                            _score += 1;
                          }
                        });

                        // Navigate to the appropriate page based on the quiz result.
                        if (_score >= (questions.length * 0.50)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighGrade(
                                      numberOfQuestions: questions.length,
                                      score: _score,
                                    )),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LowGrade(
                                      numberOfQuestions: questions.length,
                                      score: _score,
                                    )),
                          );
                        }
                      },
                      child: const Text(
                        "Submit answers",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
