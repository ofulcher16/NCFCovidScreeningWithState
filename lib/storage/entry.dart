import 'dart:async';

import 'package:ncf_covid_screening/models/contactinfomodel.dart';
import 'package:ncf_covid_screening/models/loginmodel.dart';
import 'package:ncf_covid_screening/models/questionmodel.dart';

class Entry{
  Login _login;
  ContactInfo _contactInfo;
  Questions _questions;

  StreamController<Login> loginNotifier = StreamController<Login>.broadcast();
  StreamController<ContactInfo> contactInfoNotifier = StreamController<ContactInfo>.broadcast();
  StreamController<Questions> questionNotifier = StreamController<Questions>.broadcast();

  Entry(){
    _login = Login(idNumber: "INIT");
    _contactInfo = ContactInfo(firstName: "Olympia", lastName: "Fulcher", phoneNumber: "123-456-7890", email: "olympia.fulcher16@ncf.edu", isCompleted: true);
    _questions = Questions(contact: false, symptoms: false, isCompleted: true);

    Future.delayed(Duration(milliseconds: 500), () {
      loginNotifier.add(_login);
      contactInfoNotifier.add(_contactInfo);
      questionNotifier.add(_questions);
    });
  }

  Login get login => _login;

  set login(Login x) {
    _login = x;
    loginNotifier.add(x);
  }

  ContactInfo get contactInfo => _contactInfo;

  set contactInfo(ContactInfo c) {
    _contactInfo = c;
    contactInfoNotifier.add(c);
  }

  Questions get question => _questions;

  set question(Questions q) {
    _questions = q;
    questionNotifier.add(q);
  }
}