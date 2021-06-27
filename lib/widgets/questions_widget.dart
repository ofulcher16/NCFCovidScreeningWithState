import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/blocs/question_bloc.dart';

class QuestionsWidget extends StatefulWidget {
  QuestionsWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuestionsWidgetState createState() =>
      new _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  bool _contact;
  bool _symptoms;
  bool _isCompleted;

  QuestionBloc _questionBloc;

  final List<String> questions = [
    "Have you come in contact with someone " +
        "who tested positive for COVID-19 in the last 72 hours?",
    "Are you experiencing any of the following COVID-19 symptoms today? " +
        "(See list below.)",
  ];



  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.blue,
        toggleableActiveColor: Colors.orange,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.transparent,
            width: 6,
          ),
          //borderRadius: BorderRadius.,
        ),
        child: Column(
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(color: Colors.orange, fontSize: 20.0),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            ColoredQuestionField(label: questions[0], color: Colors.blue),
            Padding(padding: EdgeInsets.all(10.0)),
            ColoredQuestionField(label: questions[1], color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class ColoredQuestionField extends StatelessWidget {
  final String label;
  final Color color;
  final int _defaultRadioValue = -1;

  const ColoredQuestionField({
    this.label,
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            label,
            style: new TextStyle(
              fontSize: 18.0,
              color: color,
            ),
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Radio(
                value: 0,
                groupValue: _defaultRadioValue,
                onChanged: (int val) {
                      //() => changeContactButton(val);
                },
              ),
              new Text(
                'No',
                style: new TextStyle(color: color, fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: _defaultRadioValue,
                onChanged: (int val) {},
              ),
              new Text(
                'Yes',
                style: new TextStyle(color: color, fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
