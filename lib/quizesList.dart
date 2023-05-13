import 'package:flutter/material.dart';

class QuizesList extends StatefulWidget {
  QuizesList(
      {super.key,
      required this.options,
      required this.correctAnswerIndex,
      required this.numberOfQuestions,
      required this.score,
      required this.isCorrect});

  final int correctAnswerIndex;
  final List<String> options;
  final int numberOfQuestions;
  int score;
  bool isCorrect;

  @override
  _QuizesListState createState() => _QuizesListState();
}

class _QuizesListState extends State<QuizesList>
    with AutomaticKeepAliveClientMixin {
  int selectedOptionIndex = -1;
  bool isSelected = false;
  bool isCorrect = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<String> options = widget.options;
    final int numberOfQuestions = widget.numberOfQuestions;
    final int correctAnswerIndex = widget.correctAnswerIndex;

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: numberOfQuestions - 1,
          itemBuilder: (BuildContext context, int index) {
            final String option = options[index];

            return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedOptionIndex = index;
                      if (selectedOptionIndex == correctAnswerIndex) {
                        widget.isCorrect = true;
                        widget.score += 1;
                      } else {
                        widget.isCorrect = false;
                      }
                    },
                  );
                  print(
                      "#################################################################");
                  // print(
                  //     "$option of index $index Clicked & isSelected is $isSelected");
                  print("selectedOptionIndex: $selectedOptionIndex");
                  print("correctAnswerIndex: $correctAnswerIndex");
                  print("isCorrect ${widget.isCorrect}");
                  print(
                      "Your Score is ${widget.score} / ${widget.numberOfQuestions}");
                  print(
                      "#################################################################");
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: selectedOptionIndex == index
                        ? Colors.teal
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(
                    selectedOptionIndex == index
                        ? (widget.isCorrect ? '$option (+1 point)' : option)
                        : option,
                    style: TextStyle(
                      color: selectedOptionIndex == index
                          ? Colors.white
                          : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ));
          },
        ),
      ],
    );
  }
}
