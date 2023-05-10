import 'package:flutter/material.dart';

class QuizesList extends StatefulWidget {
  QuizesList({
    super.key,
    required this.options,
    required this.correctAnswerIndex,
    required this.numberOfQuestions,
    required this.score,
    required this.onScoreUpdated,
  });

  final int correctAnswerIndex;
  final List<String> options;
  final int numberOfQuestions;
  final int score;
  final Function(int) onScoreUpdated;

  @override
  _QuizesListState createState() => _QuizesListState();
}

class _QuizesListState extends State<QuizesList> {
  int selectedOptionIndex = -1;
  bool isSelected = false;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.options.length,
          itemBuilder: (BuildContext context, int index) {
            final String option = widget.options[index];

            return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedOptionIndex = index;
                      if (selectedOptionIndex == widget.correctAnswerIndex) {
                        isSelected = true;
                        isCorrect = true;
                      } else {
                        isSelected = index == selectedOptionIndex;
                        isCorrect = false;
                      }
                    },
                  );
                  print(
                      "#################################################################");
                  // print(
                  //     "$option of index $index Clicked & isSelected is $isSelected");
                  print("selectedOptionIndex: $selectedOptionIndex");
                  print("correctAnswerIndex: ${widget.correctAnswerIndex}");
                  print("isCorrect: ${isCorrect}");
                  // print("Number of Questions is ${widget.numberOfQuestions}");
                  // print(
                  //     "Your Score is ${widget.score} / ${widget.numberOfQuestions}");
                  print(
                      "#################################################################");
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: isSelected && selectedOptionIndex == index
                        ? Colors.teal
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(
                    isSelected && selectedOptionIndex == index
                        ? (isCorrect ? '$option (+1 point)' : option)
                        : option,
                    style: TextStyle(
                      color: isSelected && selectedOptionIndex == index
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
