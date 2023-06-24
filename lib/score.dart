import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.result, required this.questionLength, required this.onPressed});
  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff001222),
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Score',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              child: Text('$result/$questionLength',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              radius: 60,
              backgroundColor: result == questionLength
                  ? correct
                  : result < questionLength / 2
                      ? incorrect
                      : result == questionLength / 2
                          ? Colors.yellow
                          : Colors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              result == questionLength
                  ? 'Almost There!'
                  : result < questionLength / 2
                      ? 'Try Again'
                      : 'Great!',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Start Over',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
