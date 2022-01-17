import 'dart:core';
import 'package:exam_app/app_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';


AppBrain appBrain = AppBrain();

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("اختبار",
              style:
                  TextStyle(
                      fontWeight: FontWeight.bold
                      , fontFamily: 'Cairo',
                  )
          ),
        ),
        body: const Padding(
          padding: const EdgeInsets.all(20),
          child: examPage(),
        ),
      ),
    );
  }
}

class examPage extends StatefulWidget {
  const examPage({Key? key}) : super(key: key);

  @override
  _examPageState createState() => _examPageState();
}

Widget? toast (){
     var showToast = Fluttertoast.showToast(
      msg: "This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Padding trueanswer() {
  return const Padding(
    padding: EdgeInsets.only(right: 3.0),
    child: Icon(
      Icons.thumb_up_alt,
      color: Colors.green,
      size: 35,
    ),
  );
}
Padding falseanswer() {
  return const Padding(
    padding: EdgeInsets.all(3.0),
    child: Icon(
      Icons.thumb_down_alt,
      color: Colors.red,
      size: 35,
    ),
  );
}

class _examPageState extends State<examPage> {
  List<Padding> answerResult = [];

  int trueAnswers = 0;
  int falseAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Row(
                children: answerResult,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('${appBrain.getQuestionImage()}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '${appBrain.getQuestionText()}',
                  style:const TextStyle(
                    fontSize: 22,
                    fontFamily: 'CAIRO',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FlatButton(
            color: Colors.blue,
            child: const Text(
              'صح',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Cairo'
              ),
            ),
            onPressed: () {
              setState(() {
                //to set the right answer.
                bool? correctAnswer = appBrain.getQuestionAnswer();
                if (true == correctAnswer){
                  toast();
                  answerResult.add(trueanswer());
                  trueAnswers++;
                }
                else {
                    answerResult.add(falseanswer());
                    falseAnswers++;
                }
                //To avoid range error.
                if (appBrain.isFinished() == true){
                  Alert(
                    context: context,
                    title: "عدد الاجابات الصحيحة هو $trueAnswers",
                    desc: "عدد الاجابات الخاطئة هو $falseAnswers",
                    buttons: [
                      DialogButton(
                        child:const Text(
                          "ابدا من جديد",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                  appBrain.reset(answerResult);
                  falseAnswers=0;
                  trueAnswers=0;
                }
                else {
                  appBrain.nextQuestion();
                }
              });
            },
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FlatButton(
            color: Colors.red,
            child: const Text(
              'خطأ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Cairo'
              ),
            ),
            onPressed: () {
              setState(() {
                //to set the right answer.
                bool? correctAnswer = appBrain.getQuestionAnswer();
                if (false == correctAnswer){
                  answerResult.add(trueanswer());
                  trueAnswers++;
                }
                else {
                  answerResult.add(falseanswer());
                  falseAnswers++;
                }
                //To avoid range error.
                if (appBrain.isFinished() == true){
                  Alert(
                    context: context,
                    title: "عدد الاجابات الصحيحة هو $trueAnswers",
                    desc: "عدد الاجابات الخاطئة هو $falseAnswers",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "ابدا من جديد",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                  appBrain.reset(answerResult);
                  falseAnswers=0;
                  trueAnswers=0;
                }
                else {
                  appBrain.nextQuestion();
                }
              });
            },
          ),
        )
        ),
      ],
    );
  }
}
