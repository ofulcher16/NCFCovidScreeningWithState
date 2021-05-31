import 'package:flutter/material.dart';
import 'dart:math';
import 'package:ncf_covid_screening/utils/page_type.dart';
import 'package:ncf_covid_screening/widgets/contact_info_body.dart';
import 'package:ncf_covid_screening/widgets/questions_body.dart';
import 'package:ncf_covid_screening/widgets/confirmation_body.dart';
import 'package:ncf_covid_screening/widgets/progress_stepper_wrapper.dart';

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
          firstStepCompleted: widget.firstStepCompleted,
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
