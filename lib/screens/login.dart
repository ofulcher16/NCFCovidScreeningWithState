import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/blocs/login_bloc.dart';
import 'package:ncf_covid_screening/screens/page_container.dart';
import 'package:ncf_covid_screening/utils/page_type.dart';
import 'package:ncf_covid_screening/blocs/app_state.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final idController = TextEditingController();
  LoginBloc _bloc;
  bool _idNumberHasBeenUpdated = false;
  String previousIDNumber;
  String idNumber;

  @override
  void didChangeDependencies() async {
    _bloc = AppStateContainer.of(context).blocProvider.loginBloc;
    previousIDNumber = idController.text;
    super.didChangeDependencies();
  }

  void onChangeID() {
    if (previousIDNumber == idController.text) return;
    setState(() {
      _idNumberHasBeenUpdated = true;
      idNumber = idController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    idController.addListener(onChangeID);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var _bloc = AppStateContainer.of(context).blocProvider.loginBloc;
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/four-winds.png"),
                fit: BoxFit.fitWidth,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop)),
          ),
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "myNCF Login",
                      textScaleFactor: 1.5,
                    ),
                    _controlledTextField(
                        label: "Net ID", controller: idController),
                    _makeTextField(label: "Password", obscure: true),
                    MaterialButton(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                        color: Colors.lightBlue,
                        onPressed: () =>
                            _openHomePage(context: context, fullScreen: false)),
                  ],
                )),
          ),
        ));
  }

  Widget _makeTextField({String label, bool obscure = false}) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }

  Widget _controlledTextField(
      {String label, bool obscure = false, TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void _openHomePage({BuildContext context, bool fullScreen}) {
    _bloc.updateIDNumberSink.add(idNumber);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => PageContainer(
            pageType: PageType.ContactInfo,
            secondStepCompleted: false,
          ),
        ));
  }
}
