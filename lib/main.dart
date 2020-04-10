import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  int correct = 0;

  void checkAnswer(bool answer) {
    bool questionAnswer = quizBrain.getQuestionAnswer();
    if (questionAnswer == answer) {
      correct++;
      scoreKeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scoreKeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  void showDialog(BuildContext context) {
    int totalQuestions = quizBrain.getQuestionCount();
    Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Finished ($correct / $totalQuestions)",
      desc: "Thanks for participation!",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              correct = 0;
              quizBrain.resetExam();
              scoreKeeper.clear();
              Navigator.pop(context);
            });
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  void updateQuestion(BuildContext context, bool answer) {
    setState(() {
      if (quizBrain.getExamEnable()) checkAnswer(answer);

      if (quizBrain.isExamFinished()) {
        quizBrain.setExamEnable(false);
        showDialog(context);
      }

      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                updateQuestion(context, true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                updateQuestion(context, false);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: scoreKeeper,
        ),
      ],
    );
  }
}
