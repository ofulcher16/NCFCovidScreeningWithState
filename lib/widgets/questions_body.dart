import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/screens/page_container.dart';
import 'package:ncf_covid_screening/utils/page_type.dart';
import 'package:ncf_covid_screening/widgets/questions_widget.dart';
import 'package:ncf_covid_screening/widgets/symptom_list_widget.dart';

class QuestionsBody extends StatelessWidget {
  QuestionsBody({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(15.0)),
      QuestionsWidget(title: title),
      Padding(padding: EdgeInsets.all(15.0)),
      SymptomListWidget(title: "Symptoms:"),
      MaterialButton(
          child: Text("Submit",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          padding: EdgeInsets.fromLTRB(40,10,40,10),
          color: Colors.lightBlue,
          onPressed: () => _openConfirmationPage(
              context: context,
              fullScreen: false
          )
      )
    ]
    );
  }

  void _openConfirmationPage({BuildContext context, bool fullScreen}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => PageContainer(
            pageType: PageType.Confirmation,
            firstStepCompleted: true,
            secondStepCompleted: true,
          ),
        )
    );
  }
}
