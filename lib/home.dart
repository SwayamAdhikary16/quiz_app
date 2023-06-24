import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/next_button.dart';
import 'package:quiz_app/option_card.dart';
import 'package:quiz_app/question_widget.dart';
import 'package:quiz_app/score.dart';
import './question_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Question> _questions = [
    Question(
        id: '9',
        title: 'What is 2+2?',
        options: {'5': false, '30': false, '4': true, '6': false}),
    Question(
        id: '10',
        title: 'What is 2+2?',
        options: {'5': false, '30': false, '4': true, '5': false}),
    Question(id: '11', title: 'Who painted the Mona Lisa?', options: {
      'Leonardo da Vinci': true,
      'Pablo Picasso': false,
      'Vincent van Gogh': false,
      'Michelangelo': false
    }),
    Question(
        id: '12',
        title: 'What is the chemical symbol for gold?',
        options: {'Au': true, 'Ag': false, 'Cu': false, 'Fe': false}),
    Question(
        id: '13',
        title: 'Which planet is known as the "Red Planet"?',
        options: {
          'Mars': true,
          'Jupiter': false,
          'Saturn': false,
          'Venus': false
        }),
    Question(
        id: '14',
        title: 'Who wrote the play "Romeo and Juliet"?',
        options: {
          'William Shakespeare': true,
          'Jane Austen': false,
          'Charles Dickens': false,
          'Mark Twain': false
        }),
    Question(
        id: '15',
        title: 'What is the tallest mountain in the world?',
        options: {
          'Mount Everest': true,
          'K2': false,
          'Makalu': false,
          'Kangchenjunga': false
        }),
    Question(
        id: '16',
        title: 'What is the symbol for the element oxygen?',
        options: {'O': true, 'C': false, 'H': false, 'N': false}),
    Question(
        id: '17',
        title: 'Who is the author of the Harry Potter book series?',
        options: {
          'J.K. Rowling': true,
          'Stephen King': false,
          'George R.R. Martin': false,
          'Dan Brown': false
        }),
    Question(
        id: '18',
        title: 'What is the square root of 16?',
        options: {'4': true, '8': false, '6': false, '2': false}),
    Question(id: '19', title: 'What is the capital of France?', options: {
      'Paris': true,
      'Madrid': false,
      'Rome': false,
      'Berlin': false
    }),
  ];

  int index = 0;
  bool isPressed = false;
  bool isSelected = false;
  int score = 0;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(
          context: context,
          builder: (ctx) => Result(
                result: score,
                questionLength: _questions.length,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isSelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please select an option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 10),
        ));
      }
    }
  }

  void checkAnswer(bool value) {
    if (isSelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isSelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isSelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff001222),
        elevation: 0,
        title: const Text('Quiz App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text('Score: $score'),
          )
        ],
      ),
      backgroundColor: Color(0xff001222),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            QuestionWidget(
                indexAction: index,
                question: _questions[index].title,
                totalQuestions: _questions.length),
            const Divider(
              color: neutral,
            ),
            const SizedBox(
              height: 25,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () =>
                    checkAnswer(_questions[index].options.values.toList()[i]),
                child: OptCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
