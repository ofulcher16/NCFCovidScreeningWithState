import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/screens/login.dart';
import 'package:ncf_covid_screening/blocs/contactInfo_bloc.dart';
import 'package:ncf_covid_screening/blocs/login_bloc.dart';
import 'package:ncf_covid_screening/blocs/app_state.dart';


class ContactInfoWidget extends StatefulWidget {
  ContactInfoWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() =>
      new _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  String _id;
  String _firstName;
  String _lastName;
  String _phoneNumber;
  String _email;
  bool firstStepCompleted;

  final idController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  LoginBloc _loginBloc;
  ContactInfoBloc _contactInfoBloc;

  bool _firstNameHasBeenUpdated = false;
  bool _lastNameHasBeenUpdated = false;
  bool _phoneNumberHasBeenUpdated = false;
  bool _emailHasBeenUpdated = false;

  String previousFirstName;
  String previousLastName;
  String previousPhoneNumber;
  String previousEmail;


  void asyncFetchAndSyncData() async {
    _loginBloc = AppStateContainer.of(context)?.blocProvider?.loginBloc;
    _contactInfoBloc = AppStateContainer.of(context)?.blocProvider?.contactInfoBloc;
    _id = await _loginBloc.idNumber.first.then((i) => i);
    _firstName = await _contactInfoBloc.firstName.first.then((i) => i);
    previousFirstName = firstNameController.text;
    firstNameController.text = _firstName;

    _lastName = await _contactInfoBloc.lastName.first.then((i) => i);
    previousLastName = lastNameController.text;
    lastNameController.text = _lastName;

    _phoneNumber = await _contactInfoBloc.phoneNumber.first.then((i) => i);
    previousPhoneNumber = phoneNumberController.text;
    phoneNumberController.text = _phoneNumber;

    _email = await _contactInfoBloc.email.first.then((i) => i);
    previousEmail = emailController.text;
    emailController.text = _email;

    firstStepCompleted = await _contactInfoBloc.isCompleted.first.then((i) => i);


  }

  progressChecker(){
    if (_firstName.isNotEmpty && _lastName.isNotEmpty && _phoneNumber.isNotEmpty && _email.isNotEmpty){
      firstStepCompleted = true;
      _contactInfoBloc.updateIsCompletedSink.add(true);
    }
  }

  @override
  void didChangeDependencies() async {
    asyncFetchAndSyncData();
    super.didChangeDependencies();
  }

  void onChangeFirstName() {
    if (previousFirstName == firstNameController.text) return;
    setState(() {
      _firstNameHasBeenUpdated = true;
      _firstName = firstNameController.text;
    });
    _contactInfoBloc.updateFirstNameSink.add(firstNameController.text);
    progressChecker();
  }

  void onChangeLastName() {
    if (previousLastName == lastNameController.text) return;
    setState(() {
      _lastNameHasBeenUpdated = true;
      _lastName = lastNameController.text;
    });
    _contactInfoBloc.updateLastNameSink.add(lastNameController.text);
    progressChecker();
  }

  void onChangePhoneNumber() {
    if (previousPhoneNumber == phoneNumberController.text) return;
    setState(() {
      _phoneNumberHasBeenUpdated = true;
      _phoneNumber = phoneNumberController.text;
    });
    _contactInfoBloc.updatePhoneNumberSink.add(phoneNumberController.text);
    progressChecker();
  }

  void onChangeEmail() {
    if (previousEmail == emailController.text) return;
    setState(() {
      _emailHasBeenUpdated = true;
      _email = emailController.text;
    });
    _contactInfoBloc.updateEmailSink.add(emailController.text);
    progressChecker();
  }


  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    firstNameController.addListener(onChangeFirstName);
    lastNameController.addListener(onChangeLastName);
    phoneNumberController.addListener(onChangePhoneNumber);
    emailController.addListener(onChangeEmail);

    _id = "";
    _firstName = "";
    _lastName = "";
    _phoneNumber = "";
    _email = "";
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
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
          Text( _id != null ? _id : ''),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(
            label: "First Name",
            color: Colors.blue,
            textEditingController: firstNameController,
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(
              label: "Last Name",
              color: Colors.blue,
              textEditingController: lastNameController,
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(
              label: "Phone Number",
              color: Colors.blue,
              textEditingController: phoneNumberController,
          ),
          Padding(padding: EdgeInsets.all(15.0)),
          ColoredTextField(
              label: "Email Address",
              color: Colors.blue,
              textEditingController: emailController,
          ),
          Padding(padding: EdgeInsets.all(15.0)),
        ],
      ),
    );
  }
}

class ColoredTextField extends StatelessWidget {
  final String label;
  final Color color;
  final TextEditingController textEditingController;

  const ColoredTextField({
    this.label,
    this.color,
    this.textEditingController,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
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
