import 'questions.dart';

class AppBrain{
  var _questionCounter = 0;
  final List<Questions> _questiongroup = [
    Questions(
      text:'عدد الكواكب في المجموعة الشمسية ثمانية كواكب ؟',
      image: 'images/image-1.jpg',
      answer: true,
    ),
    Questions(
      text:'القطط هي حيوانات لاحمة ؟',
      image: 'images/image-2.jpg',
      answer: true,
    ),
    Questions(
      text:'الصين موجودة في القارة الافريقية ؟',
      image: 'images/image-3.jpg',
      answer: false,
    ),
    Questions(
      text:'الارض مسطحة وليست كروية ؟',
      image: 'images/image-4.jpg',
      answer: false,
    ),
    Questions(
      text: 'باستطاعة الانسان البقاء على قيد الحياة دون اكل اللحوم ؟',
      image: 'images/image-5.jpg',
      answer: true,
    ),
    Questions(
        answer: false,
        image: 'images/image-6.jpg',
        text: 'الشمس تدور حول الارض والارض تدور حول القمر ؟'
    ),
    Questions(
      answer: false,
      image: 'images/image-7.jpg',
      text: 'الحيوانات لا تشعر بالالم ؟',
    ),
  ];

  bool isFinished (){
    if (_questionCounter >= _questiongroup.length-1){
      return true;
    }
    else {
      return false;
    }
  }

  void reset (List ans){
    _questionCounter = 0;
    ans.clear();
  }
  void nextQuestion(){
      _questionCounter++;
  }

  String? getQuestionText(){
    return _questiongroup[_questionCounter].qtext;
  }
  String? getQuestionImage(){
    return _questiongroup[_questionCounter].qimage;
  }
  bool? getQuestionAnswer(){
    return _questiongroup[_questionCounter].qanswer;
  }
}
