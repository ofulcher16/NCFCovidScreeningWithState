import 'dart:async';


import 'package:ncf_covid_screening/services/questionservice.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  final QuestionService _service;

  //Inputs
  StreamController<bool> updateContactSink = StreamController<bool>();
  StreamController<bool> updateSymptomsSink = StreamController<bool>();
  StreamController<bool> updateIsCompletedSink = StreamController<bool>();

  //outputs
  Stream<bool> get contact => _contactStreamController.stream;
  StreamController _contactStreamController = BehaviorSubject<bool>();

  Stream<bool> get symptoms => _symptomsStreamController.stream;
  StreamController _symptomsStreamController = BehaviorSubject<bool>();

  Stream<bool> get isCompleted => _isCompletedStreamController.stream;
  StreamController _isCompletedStreamController = BehaviorSubject<bool>();

  QuestionBloc(this._service){
    Stream contactStream = updateContactSink.stream;
    // Listen to inputs
    contactStream.listen((value) {
      //print('Value from controller: $value');
      _contactStreamController.add(value);
    });

    Stream symptomsStream = updateSymptomsSink.stream;
    // Listen to inputs
    symptomsStream.listen((value) {
      //print('Value from controller: $value');
      _symptomsStreamController.add(value);
    });

    Stream isCompletedStream = updateIsCompletedSink.stream;
    // Listen to inputs
    isCompletedStream.listen((value) {
      //print('Value from controller: $value');
      _isCompletedStreamController.add(value);
    });
  }

  void _handleUpdateContact(bool contact) {
    _service.updateContact(contact);
  }

  void _handleUpdateSymptoms(bool symptoms) {
    _service.updateSymptoms(symptoms);
  }

  void _handleUpdateIsCompleted(bool isCompleted) {
    _service.updateIsCompleted(isCompleted);
  }

  close() {
    updateContactSink.close();
    _contactStreamController.close();

    updateSymptomsSink.close();
    _symptomsStreamController.close();

    updateIsCompletedSink.close();
    _isCompletedStreamController.close();
  }
}