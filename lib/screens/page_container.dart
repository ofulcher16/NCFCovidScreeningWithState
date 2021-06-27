import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ncf_covid_screening/utils/page_type.dart';
import 'package:ncf_covid_screening/widgets/contact_info_body.dart';
import 'package:ncf_covid_screening/widgets/questions_body.dart';
import 'package:ncf_covid_screening/widgets/confirmation_body.dart';
import 'package:ncf_covid_screening/widgets/progress_stepper_wrapper.dart';
import 'package:ncf_covid_screening/blocs/contactInfo_bloc.dart';
import 'package:ncf_covid_screening/blocs/app_state.dart';

class PageContainer extends StatefulWidget {
  PageContainer({
    Key key,
    @required this.pageType,
    @required this.firstStepCompleted,
    @required this.secondStepCompleted,
  }) : super(key: key);

  final PageType pageType;

  // these should be stored in the bloc
  final bool firstStepCompleted;
  final bool secondStepCompleted;

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  ContactInfoBloc _contactInfoBloc;
  bool _firstStepCompleted = false;
  // for spinning the four winds
  final controller = ScrollController(initialScrollOffset: 10);
  double angle = 0;

  Widget get appBar => AppBar(
    title: Text("NCF COVID-19 Symptom Tracker"),
    flexibleSpace: Image(
       image: AssetImage('images/ncf-bayfront.jpeg'),
       fit: BoxFit.cover,
       color: Colors.black.withOpacity(0.5),
       colorBlendMode: BlendMode.dstATop
    ),
    backgroundColor: Colors.transparent,
  );

  String get pageTitle {
    switch (widget.pageType) {
      case PageType.ContactInfo:
        return "Contact Information";
      case PageType.Questions:
        return "Questions";
        break;
      case PageType.Confirmation:
        return "Confirmation";
      default:
        return "";
    }
  }

  void asyncFetchAndSyncData() async{
    _contactInfoBloc = AppStateContainer.of(context)?.blocProvider?.contactInfoBloc;
    _firstStepCompleted = await _contactInfoBloc.isCompleted.first.then((i) => i);
  }

  @override
  void didChangeDependencies() async {
    asyncFetchAndSyncData();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        angle = controller.offset * pi;
      });
    });
  }

  @override
  Widget get body {
    var pageBody;
    var scroll;
    switch (widget.pageType) {
      case PageType.ContactInfo:
        pageBody = ContactInfoBody(title: pageTitle);
        scroll = true;
        break;
      case PageType.Questions:
        pageBody = QuestionsBody(title: pageTitle);
        scroll = true;
        break;
      case PageType.Confirmation:
        pageBody = ConfirmationBody();
        scroll = false;
        break;
      default:
        pageBody = ContactInfoBody();
        scroll = true;
    }
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child){
              return Transform.rotate(
                  angle: controller.hasClients ? controller.offset / 200 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/four-winds.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ));
            }),
        Container(
          color: Color.fromRGBO(255, 255, 255, 0.9),
        ),
        _makeMainBody(pageBody, scroll),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  Widget _makeMainBody(Widget pageBody, bool scroll) {
    var child = Column(
      children: <Widget> [
        Padding(padding: EdgeInsets.fromLTRB(20.0,20.0,20.0,4.0)),
        Text(
          "Progress",
          style: TextStyle(color: Colors.orange, fontSize: 20.0),
        ),
        ProgressStepperWrapper(
          firstStepCompleted: _firstStepCompleted,
          secondStepCompleted: widget.secondStepCompleted,
        ),
        pageBody,
      ],
    );
    if (scroll) {
      return SingleChildScrollView(
          controller: controller,
          child: child
      );
    }
    else {
      return child;
    }
  }
}
