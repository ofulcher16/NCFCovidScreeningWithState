import 'package:flutter/material.dart';

class SymptomListWidget extends StatelessWidget {
  SymptomListWidget({Key key, this.title}) : super(key: key);

  final String title;
  final List<String> symptoms = [
    "-Temperature 100.4 F or higher",
    "-Loss of taste and/or smell",
    "-Sore throat",
    "-Dry cough",
    "-Nausea and/or vomiting",
    "-Abdominal/stomach pain",
    "-Dizziness/Lightheadedness",
    "-Chills",
    "-Unusually intense headache",
    "-Severe fatigue",
    "-Eye discomfort or excessive tears",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
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
            title,
            style: TextStyle(color: Colors.orange, fontSize: 20.0),
          ),
          Divider(height: 8.0),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: symptoms.map((item) =>
                Text(item,
                    style: TextStyle(color: Colors.blue, fontSize: 18.0)
                )
            ).toList()
          ),
      ],
      ),
    );
  }
}

class ColoredTextField extends StatelessWidget {
  final String label;
  final Color color;

  const ColoredTextField({
    this.label,
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: color),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: color)),
      ),
    );
  }
}
