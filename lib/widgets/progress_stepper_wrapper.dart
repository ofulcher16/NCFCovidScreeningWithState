import 'package:flutter/material.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:ncf_covid_screening/utils/page_type.dart';

class ProgressStepperWrapper extends StatelessWidget {
  final bool firstStepCompleted;
  final bool secondStepCompleted;
  final double stepperWidth = 200;
  final double stepperHeight = 25;
  final int stepCount = 2;
  final Color defaultColor = Colors.red;
  final Color progressColor = Colors.green;

  ProgressStepperWrapper({
    Key key,
    @required this.firstStepCompleted,
    @required this.secondStepCompleted,
  }) : super(key: key);

    @override Widget build(BuildContext context) {
      return Container(
          padding: EdgeInsets.all(20.0),
    child: ProgressStepper(
          width: stepperWidth,
          height: stepperHeight,
          color: defaultColor,
          progressColor: progressColor,
          stepCount: stepCount,
          builder: (index) {
            double widthOfStep = stepperWidth / stepCount;
            if (index == 1) {
              return ProgressStepWithChevron(
                width: widthOfStep,
                defaultColor: defaultColor,
                progressColor: progressColor,
                wasCompleted: firstStepCompleted,
                child: Center(child: Text("Contact Info")),
              );
            }
            else { // index == 2
              return ProgressStepWithChevron(
                width: widthOfStep,
                defaultColor: defaultColor,
                progressColor: progressColor,
                wasCompleted: secondStepCompleted,
                child: Center(child: Text("Questions")),
              );
            }
          },
   ),
    );
  }
}
