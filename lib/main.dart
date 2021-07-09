import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBank questionBank = QuestionBank();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  // This widget is the root of your application.
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
  List<Widget> scoreKeeper = [];

  Icon iconCorrect = Icon(Icons.check, color: Colors.lightGreenAccent);
  Icon iconInCorrect = Icon(Icons.close, color: Colors.red);
  bool checkLastQuestion = false;
  void checkCorrect(bool answerUser) {
    setState(() {
      if (!questionBank.nextQuestion()) {
        if (!checkLastQuestion) {
          addIconInScoreKeeper(answerUser);
          checkLastQuestion = true;
        }
        showAlertReach();
      } else {
        addIconInScoreKeeper(answerUser);
      }
    });
  }

  void addIconInScoreKeeper(bool answerUser) {
    if (questionBank.checkAnswerUser(answerUser)) {
      scoreKeeper.add(iconCorrect);
    } else {
      scoreKeeper.add(iconInCorrect);
    }
  }

  void showAlertReach() {
    int correct = questionBank.getCorrectAnswerUser();
    Alert(
        context: context,
        title: "Result of quiz",
        desc: "You have $correct answer correct. Do you want to reset quiz?",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.lightBlueAccent,
          ),
          DialogButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              setState(() {
                questionBank.resetQuestionNumber();
                scoreKeeper.clear();
                checkLastQuestion = false;
              });
            },
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.redAccent,
          )
        ]).show();
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
                questionBank.getQuestion(),
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
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkCorrect(true);
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
                checkCorrect(false);
                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
