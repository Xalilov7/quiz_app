import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer ? selectedAnswer;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 50, 80),
        body: Container(
          child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Simple Quiz App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              ),
              ),
              _questionWidget(),
              _answerList(),
              _nextButton()
            ],
          ),
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Question ${currentQuestionIndex + 1}/${questionList.length
            .toString()}",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(questionList[currentQuestionIndex].questionText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
  }


 _answerList(){
   return Column(
     children: questionList[currentQuestionIndex].answersList.map((e) => _answerButton(e)).toList(),
   );
}

  Widget _answerButton(Answer answer){
    bool isSelected = answer==selectedAnswer;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(
          answer.answerText
        ),
        style: ElevatedButton.styleFrom(
          shape:  StadiumBorder(),
          primary: isSelected ? Colors.orange : Colors.white,
          onPrimary:  isSelected ? Colors.white : Colors.black,
        ),
    onPressed: (){
          if(selectedAnswer == null){
            if(answer.isCorrect){
              score++;
            }
          }
            setState(() {
            selectedAnswer = answer;
          });
    },
      ),
    );
 }

 _nextButton(){
    bool isLastQuestion = false;
    if(currentQuestionIndex == questionList.length -1){
      isLastQuestion = true;
    }

   return Container(
     width: MediaQuery.of(context).size.width * 0.5,
     height: 48,
     child: ElevatedButton(
       child: Text( isLastQuestion? "Sumbit": "Next"),
       style: ElevatedButton.styleFrom(
         shape:  StadiumBorder(),
         primary:  Colors.blue ,
         onPrimary: Colors.white ,
       ),
       onPressed: (){
         if(isLastQuestion){
          showDialog(context: context, builder: (_) => _showScoreDialog());
         } else{
          setState(() {
            selectedAnswer = null;
            currentQuestionIndex ++;
          });
         }
       },
     ),
   );
 }
 _showScoreDialog(){
    bool isPassed = false;
    if(score >= questionList.length * 0.6){
     isPassed = true;
    }
    String title = isPassed? "Passed" : "Failed";

    return AlertDialog(
      title: Text(title + " | Score is $score",
      style: TextStyle(
        color: isPassed ? Colors.green : Colors.redAccent
      ),
      ),
      content: ElevatedButton(
        child: Text("Restart"),
        onPressed: (){
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
 }

}
