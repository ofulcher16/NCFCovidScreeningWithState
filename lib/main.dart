import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/blocs/contactInfo_bloc.dart';
import 'package:ncf_covid_screening/blocs/login_bloc.dart';
import 'package:ncf_covid_screening/screens/login.dart';
import 'dart:async';
import 'package:ncf_covid_screening/blocs/app_state.dart';
import 'package:ncf_covid_screening/services/contactinfoservice.dart';
import 'package:ncf_covid_screening/storage/entry.dart';
import 'package:ncf_covid_screening/services/login_service.dart';

Future<void> main() async {
  var entry = Entry();
  var loginService = LoginServiceTemp(entry);
  var contactInfoService = ContactInfoServiceTemp(entry);

  /// Starting here, everything is used regardless of dependencies
  var blocProvider = BlocProvider(
    loginBloc: LoginBloc(loginService),
    contactInfoBloc: ContactInfoBloc(contactInfoService)
  );

  /// Wrap the app in the AppBloc
  /// An inherited widget which keeps track of
  /// the state of the app, including the
  /// active page
  runApp(
    AppStateContainer(
      blocProvider: blocProvider,
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New College COVID-19 Screening',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(title: "NCF COVID-19 Symptom Tracker"),
    );
  }
}
