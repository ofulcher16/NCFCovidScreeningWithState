/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'dart:async';


import 'package:ncf_covid_screening/services/contactinfoservice.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoBloc {
  final ContactInfoService _service;

  // Inputs
  StreamController<String> updateFirstNameSink = StreamController<String>();
  StreamController<String> updateLastNameSink = StreamController<String>();
  StreamController<String> updatePhoneNumberSink = StreamController<String>();
  StreamController<String> updateEmailSink = StreamController<String>();
  StreamController<bool> updateIsCompletedSink = StreamController<bool>();


  // Outputs
  Stream<String> get firstName => _firstNameStreamController.stream;
  StreamController _firstNameStreamController = BehaviorSubject<String>();

  Stream<String> get lastName => _lastNameStreamController.stream;
  StreamController _lastNameStreamController = BehaviorSubject<String>();

  Stream<String> get phoneNumber => _phoneNumberStreamController.stream;
  StreamController _phoneNumberStreamController = BehaviorSubject<String>();

  Stream<String> get email => _emailStreamController.stream;
  StreamController _emailStreamController = BehaviorSubject<String>();

  Stream<bool> get isCompleted => _isCompletedStreamController.stream;
  StreamController _isCompletedStreamController = BehaviorSubject<bool>();

  ContactInfoBloc(this._service) {
    Stream firstNameStream = updateFirstNameSink.stream;


    Stream lastNameStream = updateLastNameSink.stream;

    lastNameStream.listen((value) {
      //print('Value from controller: $value');
      _lastNameStreamController.add(value);
    });

    Stream phoneNumberStream = updatePhoneNumberSink.stream;
    // Listen to inputs
    phoneNumberStream.listen((value) {
      //print('Value from controller: $value');
      _phoneNumberStreamController.add(value);
    });

    Stream emailStream = updateEmailSink.stream;
    // Listen to inputs
    emailStream.listen((value) {
      //print('Value from controller: $value');
      _emailStreamController.add(value);
    });

    Stream isCompletedStream = updateIsCompletedSink.stream;
    // Listen to inputs
    isCompletedStream.listen((value) {
      //print('Value from controller: $value');
      _isCompletedStreamController.add(value);
    });

  }

  void _handleUpdateFirstName(String firstName) {
    _service.updateFirstName(firstName);
  }

  void _handleUpdateLastName(String lastName) {
    _service.updateLastName(lastName);
  }

  void _handleUpdatePhoneNumber(String phoneNumber) {
    _service.updatePhoneNumber(phoneNumber);
  }

  void _handleUpdateEmail(String email) {
    _service.updateEmail(email);
  }

  void _handleUpdateIsCompleted(bool isCompleted) {
    _service.updateIsCompleted(isCompleted);
  }

  close() {
    updateFirstNameSink.close();
    _firstNameStreamController.close();

    updateLastNameSink.close();
    _lastNameStreamController.close();

    updatePhoneNumberSink.close();
    _phoneNumberStreamController.close();

    updateEmailSink.close();
    _emailStreamController.close();

    updateIsCompletedSink.close();
    _isCompletedStreamController.close();
  }
}