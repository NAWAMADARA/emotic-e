import 'package:flutter/material.dart';



class QuizQuestion {
  final String question;
  final List<String> choices;
  final int correctAnswer;

  QuizQuestion(this.question, this.choices, this.correctAnswer);
}


class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<QuizQuestion> quizQuestions = [];
  List<int> selectedAnswers = [-1, -1, -1, -1, -1];
  int totalMarks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _createQuiz();
            },
            child: const Text('Create a Quiz'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context,index){
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text('Q${index + 1}: ${quizQuestions[index].question}'),
                        for (int j = 0; j < 4; j++)
                          ListTile(
                            title: Text(quizQuestions[index].choices[j]),
                            leading: Radio<int>(
                              value: j,
                              groupValue: selectedAnswers[index],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[index] = value!;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
            itemCount: quizQuestions.length,),
          ),
          ElevatedButton(
            onPressed: () {
              _calculateMarks();
            },
            child: const Text('Submit Quiz'),
          ),
          Text('Total Marks: $totalMarks'),
        ],
      ),
    );
  }

  void _createQuiz() {
    quizQuestions = []; // Clear previous questions
    selectedAnswers = [-1, -1, -1, -1, -1]; // Reset selected answers

    // Define your quiz questions here
    quizQuestions.add(QuizQuestion(
      'What is the capital of France?',
      ['Berlin', 'London', 'Paris', 'Madrid'],
      2, // Correct answer index (0-based)
    ));
    quizQuestions.add(QuizQuestion(
      'Which planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Venus', 'Jupiter'],
      1,
    ));
    quizQuestions.add(QuizQuestion(
      'What is the largest mammal in the world?',
      ['Elephant', 'Giraffe', 'Blue Whale', 'Lion'],
      2,
    ));
    quizQuestions.add(QuizQuestion(
      'Which gas do plants absorb from the atmosphere?',
      ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      1,
    ));
    quizQuestions.add(QuizQuestion(
      'What is the chemical symbol for gold?',
      ['Au', 'Ag', 'Fe', 'Hg'],
      0,
    ));

    setState(() {});
  }

  void _calculateMarks() {
    int correctAnswers = 0;
    for (int i = 0; i < quizQuestions.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i].correctAnswer) {
        correctAnswers++;
      }
    }
    totalMarks = correctAnswers;
    setState(() {});
  }
}