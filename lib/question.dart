class Question {
  late String _question;
  late bool _answer;

  Question(String question, bool answer) {
    this._question = question;
    this._answer = answer;
  }

  void setQuestion(String question) {
    this._question = question;
  }

  void setAnswer(bool answer) {
    this._answer = answer;
  }

  String getQuestion() {
    return this._question;
  }

  bool getAnswer() {
    return this._answer;
  }
}
