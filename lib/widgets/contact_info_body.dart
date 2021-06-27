import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ncf_covid_screening/screens/page_container.dart';
import 'package:ncf_covid_screening/utils/page_type.dart';
import 'package:ncf_covid_screening/widgets/contact_info_widget.dart';

class ContactInfoBody extends StatelessWidget {
  ContactInfoBody({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ContactInfoWidget(title: title),
      MaterialButton(
          child: Text("Continue",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          padding: EdgeInsets.fromLTRB(40,10,40,10),
          color: Colors.lightBlue,
          onPressed: () => _openQuestionPage(context: context, fullScreen: false)
      )
    ]
    );
  }

  void _openQuestionPage({BuildContext context, bool fullScreen}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => PageContainer(
            pageType: PageType.Questions,
            secondStepCompleted: false,
          ),
        )
    );
  }
}
