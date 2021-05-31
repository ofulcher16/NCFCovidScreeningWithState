import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/screens/login.dart';
import 'package:ncf_covid_screening/blocs/login_bloc.dart';
import 'package:ncf_covid_screening/blocs/app_state.dart';

class ContactInfoWidget extends StatefulWidget {
  ContactInfoWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactInfoWidgetState createState() =>
      _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  TextEditingController _idController;
  LoginBloc _bloc;
  String _id;
  StreamController _streamController;

  @override
  void didChangeDependencies() async {
    _bloc = AppStateContainer.of(context)?.blocProvider?.loginBloc;
    var id = await _bloc.idNumber.first.then((i) => i);
    print(id);
    _streamController = ;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.transparent,
          width: 6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(15.0)),
          Text(
            widget.title,
            style: TextStyle(color: Colors.orange, fontSize: 20.0),
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          Text( ""),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(label: "First Name", color: Colors.blue),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(label: "Last Name", color: Colors.blue),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(label: "Phone Number", color: Colors.blue),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(label: "Email Address", color: Colors.blue),
          Padding(padding: EdgeInsets.all(15.0)),
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
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
      ),
    );
  }
}
