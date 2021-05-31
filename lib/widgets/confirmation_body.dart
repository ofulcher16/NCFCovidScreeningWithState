import 'package:flutter/material.dart';
import 'dart:math';

class ConfirmationBody extends StatelessWidget {

  ConfirmationBody({Key key, }) : super(key: key);

  final List<String> text = [
    "Please go back to complete the contact information.",
    "Please go back to answer the questions completely.",
    "You indicated that you are not feeling well or that you have recently come "
    "into contact with someone who tested positive for COVID. \n\n"
    "Please isolate yourself and you will be contacted within the day. "
    "If you don't hear from Student Health today or are concerned about "
    "the severity of your symptoms, please call 487-4254 option 2 and "
    "make an appointment to see a practitioner.",
    "Reported Symptom Free!"
  ];

  @override
  Widget build(BuildContext context) {
    var status = Random().nextInt(4);
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(10,50,10,50),
          child: Text(text.elementAt(status), textScaleFactor: 1.5,
            style: TextStyle(),
            textAlign: TextAlign.justify,
          )
      ),
    );
  }
}