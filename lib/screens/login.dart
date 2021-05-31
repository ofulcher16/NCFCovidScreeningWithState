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
  TextEditingController _idController;
  LoginBloc _bloc;
  bool _idNumberHasBeenUpdated = false;
  String previousIDNumber;

  @override
  void didChangeDependencies() async {
    _bloc = AppStateContainer.of(context)?.blocProvider?.loginBloc;
    var id = await _bloc.idNumber.first.then((i) => i);
    _idController = TextEditingController(text: id);

    previousIDNumber = _idController.text;

    _idController.addListener(onChangeID);

    super.didChangeDependencies();
  }

  void onChangeID() {
    if (previousIDNumber == _idController.text) return;
    setState(() {
      _idNumberHasBeenUpdated = true;
    });
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
                        label: "Net ID", controller: _idController),
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => PageContainer(
            pageType: PageType.ContactInfo,
            firstStepCompleted: false,
            secondStepCompleted: false,
          ),
        ));
  }
}
