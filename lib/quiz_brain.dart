import 'question.dart';

class QuizBrain{

  List<Question> questionBank = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];

  int currentQuestion=0;
  bool examEnable=true;

  void nextQuestion(){
    if(currentQuestion < questionBank.length-1){
      currentQuestion++;
    }
  }

  String getQuestionText(){
    return questionBank[currentQuestion].question;
  }

  bool getQuestionAnswer(){
    return questionBank[currentQuestion].answer;
  }

  bool isExamFinished(){
    return currentQuestion + 1 == questionBank.length;
  }

  void setExamEnable(bool status){
    examEnable=status;
  }

  bool getExamEnable(){
    return examEnable;
  }

  void resetExam(){
    currentQuestion=0;
    examEnable=true;
  }

  int getQuestionCount(){
    return questionBank.length;
  }

}