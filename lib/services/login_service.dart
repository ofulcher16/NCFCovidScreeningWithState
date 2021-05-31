import 'dart:async';
import 'package:ncf_covid_screening/models/loginmodel.dart';
import 'package:ncf_covid_screening/storage/entry.dart';


abstract class LoginService {
  Stream<String> streamIDNumber();
  Future<void> updateIDNumber(String idNumber);
}

/// Example implementation that *does not persist beyond the session*
class LoginServiceTemp implements LoginService {
  final Entry entry;

  LoginServiceTemp(this.entry);

  @override
  Future updateIDNumber(String idNumber) async {
    entry.login.idNumber = idNumber;
  }

  @override
  Stream<String> streamIDNumber() {
    return entry.loginNotifier.stream.map((event) => event.idNumber);
  }

}
