/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'dart:async';


import 'package:ncf_covid_screening/services/login_service.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final LoginService _service;

  // Inputs
  StreamController<String> updateIDNumberSink = StreamController<String>();

  // Outputs
  Stream<String> get idNumber => _idNumberStreamController.stream;
  StreamController _idNumberStreamController = BehaviorSubject<String>();

  LoginBloc(this._service) {
    // Listen to inputs
    updateIDNumberSink.stream.listen((_handleUpdateIDNumber));

    // listen for incoming outputs
    _service.streamIDNumber().listen((String idNumber) {
      _idNumberStreamController.add(idNumber);
    });
  }

  void _handleUpdateIDNumber(String idNumber) {
    _service.updateIDNumber(idNumber);
  }


  close() {
    updateIDNumberSink.close();
    _idNumberStreamController.close();
  }
}

