import "dart:async";
import 'package:ncf_covid_screening/models/questionmodel.dart';
import 'package:ncf_covid_screening/storage/entry.dart';

abstract class QuestionService {
  Stream<bool> streamContact();
  Future<void> updateContact(bool contact);

  Stream<bool> streamSymptoms();
  Future<void> updateSymptoms(bool symptoms);

  Stream<bool> streamIsCompleted();
  Future<void> updateIsCompleted(bool isCompleted);
}

class QuestionServiceTemp implements QuestionService {
  final Entry entry;

  QuestionServiceTemp(this.entry);

  @override
  Future updateContact(bool contact) async {
    entry.question.contact= contact;
  }

  @override
  Stream<bool> streamContact() {
    return entry.questionNotifier.stream.map((event) => event.contact);
  }

  @override
  Future updateSymptoms(bool symptoms) async {
    entry.question.symptoms= symptoms;
  }

  @override
  Stream<bool> streamSymptoms() {
    return entry.questionNotifier.stream.map((event) => event.symptoms);
  }

  @override
  Future updateIsCompleted(bool isCompleted) async {
    entry.question.isCompleted= isCompleted;
  }

  @override
  Stream<bool> streamIsCompleted() {
    return entry.questionNotifier.stream.map((event) => event.isCompleted);
  }
}