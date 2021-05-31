import 'dart:async';
import 'package:ncf_covid_screening/models/contactinfomodel.dart';
import 'package:ncf_covid_screening/storage/entry.dart';


abstract class ContactInfoService {
  Stream<String> streamFirstName();
  Future<void> updateFirstName(String firstName);

  Stream<String> streamLastName();
  Future<void> updateLastName(String lastName);

  Stream<String> streamPhoneNumber();
  Future<void> updatePhoneNumber(String phoneNumber);

  Stream<String> streamEmail();
  Future<void> updateEmail(String email);

  Stream<bool> streamIsCompleted();
  Future<void> updateIsCompleted(bool completed);
}

/// Example implementation that *does not persist beyond the session*
class ContactInfoServiceTemp implements ContactInfoService {
  final Entry entry;

  ContactInfoServiceTemp(this.entry);

  @override
  Future updateFirstName(String firstName) async {
    entry.contactInfo.firstName = firstName;
  }

  @override
  Stream<String> streamFirstName() {
    return entry.contactInfoNotifier.stream.map((event) => event.firstName);
  }

  @override
  Future updateLastName(String lastName) async {
    entry.contactInfo.lastName = lastName;
  }

  @override
  Stream<String> streamLastName() {
    return entry.contactInfoNotifier.stream.map((event) => event.lastName);
  }

  @override
  Future updatePhoneNumber(String phoneNumber) async {
    entry.contactInfo.phoneNumber = phoneNumber;
  }

  @override
  Stream<String> streamPhoneNumber() {
    return entry.contactInfoNotifier.stream.map((event) => event.phoneNumber);
  }

  @override
  Future updateEmail(String email) async {
    entry.contactInfo.email = email;
  }

  @override
  Stream<String> streamEmail() {
    return entry.contactInfoNotifier.stream.map((event) => event.email);
  }

  @override
  Future updateIsCompleted(bool completed) async {
    entry.contactInfo.isCompleted = completed;
  }

  @override
  Stream<bool> streamIsCompleted() {
    return entry.contactInfoNotifier.stream.map((event) => event.isCompleted);
  }

}
