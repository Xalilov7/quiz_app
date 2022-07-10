class Question{
 final String questionText;
 final List<Answer> answersList;
 Question(this.questionText, this.answersList);
}

class Answer{
  final String answerText;
  final bool isCorrect;
  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions(){
  List<Question> list = [];
  list.add(Question("Who is the owner of Flutter", [
    Answer("Nokia", false),
    Answer("Samsung", false),
    Answer("Google", true),
    Answer("Apple", false)
  ]));

  list.add(Question("Who is the owner of Iphone", [
    Answer("Nokia", false),
    Answer("Samsung", false),
    Answer("Google", false),
    Answer("Apple", true)
  ]));
  list.add(Question("Youtube is ____ platform?", [
    Answer("Music sharing", false),
    Answer("Video sharing", false),
    Answer("Live Streaming", false),
    Answer("All of the above", true)
  ]));
  list.add(Question("Flutter user dart as a language", [
    Answer("false", false),
    Answer("true", true),
  ]));

  
  
  return list;
}





